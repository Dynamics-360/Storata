codeunit 50850 Processing
{

    procedure ProcessData(var ImportHeader: Record "Import Sales Header")
    begin
        if ImportHeader.Count > 1 then begin
            repeat
                if not CreateOrder(ImportHeader) then begin
                    ImportHeader."Error Description" := GetLastErrorText;
                    ImportHeader.Created := false;
                    ImportHeader.Modify();
                end;
            until ImportHeader.Next() = 0;
        end else begin
            if not CreateOrder(ImportHeader) then begin
                ImportHeader."Error Description" := GetLastErrorText;
                ImportHeader.Created := false;
                ImportHeader.Modify();
            end;
        end;
    end;

    [TryFunction]
    local procedure CreateOrder(ImportHead: Record "Import Sales Header")
    var
        ImportSalesLines: Record "Import Sales Lines";
        SalesHeader: Record "Sales Header";
        Location: Record Location;
        NoSeries: Record "No. Series";
        SalesRecSetup: Record "Sales & Receivables Setup";
    begin
        Clear(SalesHeader);
        if ImportHead.Created then
            exit;
        SalesRecSetup.Get();
        if SalesRecSetup."Order Nos." <> '' then begin
            if NoSeries.Get(SalesRecSetup."Order Nos.") then
                if NoSeries."Manual Nos." = false then begin
                    NoSeries."Manual Nos." := true;
                    NoSeries.Modify();
                end;
        end;

        SalesHeader.Reset();
        if SalesHeader.Get(SalesHeader."Document Type"::Order, ImportHead."Order No.") then
            Error('Pace order no %1 already exist.', ImportHead."Order No.");

        SalesHeader.Init();
        SalesHeader."No." := ImportHead."Order No.";
        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.Validate("Sell-to Customer No.", ImportHead."Customer No.");
        SalesHeader.Validate("External Document No.", ImportHead."Order Reference");
        SalesHeader.Validate("Location Code", ImportHead.Warehouse);
        SalesHeader.Validate("Shipment Method Code", ImportHead."Delivery Mode");
        SalesHeader.Validate("Run No.", ImportHead."Run Number");
        SalesHeader.Validate("Requested Delivery Date", ImportHead."Req. Receipt Date");
        SalesHeader.Validate("Shipment Date", ImportHead."Shipping Date");
        if SalesHeader.Insert() then begin
            ImportHead.Created := true;
            ImportHead.Modify();
            ImportSalesLines.Reset();
            ImportSalesLines.SetRange("Order No.", ImportHead."Order No.");
            ImportSalesLines.SetRange(Created, false);
            if ImportSalesLines.FindSet() then
                CreateLines(SalesHeader, ImportSalesLines);
        end
        else
            Error(GetLastErrorText);

        if ImportHead.Created then
            ImportHead.Delete(true);
    end;

    local procedure CreateLines(SalesHead: Record "Sales Header"; var ImportSalesLines: Record "Import Sales Lines")
    var
        SalesLine: Record "Sales Line";
    begin
        repeat
            Clear(SalesLine);
            SalesLine.init();
            SalesLine.Validate("Document Type", SalesHead."Document Type");
            SalesLine.Validate("Document No.", SalesHead."No.");
            SalesLine."Line No." := ImportSalesLines."Line No.";
            SalesLine.Validate(Type, SalesLine.Type::Item);
            SalesLine.Validate("No.", ImportSalesLines."Item No.");
            SalesLine.Validate(Quantity, ImportSalesLines.Quantity);
            SalesLine.Validate("Location Code", ImportSalesLines.Warehouse);
            if SalesLine.Insert() then begin
                ImportSalesLines.Created := true;
                ImportSalesLines.Modify();
            end;
        until ImportSalesLines.Next() = 0;
    end;

    procedure ImportDataFromExcel()
    var
        ImportHeadRec: Record "Import Sales Header";
        ImportLineRec: Record "Import Sales Lines";
        ShipDate: Text;
        RecpDate: Text;
    begin
        Rec_ExcelBuffer.DeleteAll();
        Rows := 0;
        Columns := 0;
        DialogCaption := 'Select File to upload';
        UploadResult := UploadIntoStream(DialogCaption, '', '', Name, NVInStream);
        // If Name <> '' then
        //     Sheetname := Rec_ExcelBuffer.SelectSheetsNameStream(NVInStream)

        // else
        //     exit;

        Rec_ExcelBuffer.Reset();
        Rec_ExcelBuffer.OpenBookStream(NVInStream, 'Sales Order Header');
        Rec_ExcelBuffer.ReadSheet();
        // Commit();

        Rec_ExcelBuffer.Reset();
        Rec_ExcelBuffer.SetRange("Column No.", 1);
        Rows := Rec_ExcelBuffer.Count;
        //Finding total number of columns to import

        Rec_ExcelBuffer.Reset();

        Rec_ExcelBuffer.SetRange("Row No.", 1);

        if Rec_ExcelBuffer.FindFirst() then
            repeat

                Columns := Columns + 1;

            until Rec_ExcelBuffer.Next() = 0;

        //Function to Get the last line number in Job Journal

        for RowNo := 3 to Rows do begin
            Clear(ImportHeadRec);
            //Message(GetValueAtIndex(RowNo, 1));
            ImportHeadRec.Init;
            ImportHeadRec."Order No." := GetValueAtIndex(RowNo, 1);
            ImportHeadRec."Customer No." := GetValueAtIndex(RowNo, 2);
            ImportHeadRec."Order Reference" := GetValueAtIndex(RowNo, 3);
            ImportHeadRec.Warehouse := GetValueAtIndex(RowNo, 4);
            ImportHeadRec."Delivery Mode" := GetValueAtIndex(RowNo, 5);
            ImportHeadRec."Run Number" := GetValueAtIndex(RowNo, 6);
            ShipDate := GetValueAtIndex(RowNo, 7);
            Evaluate(ImportHeadRec."Shipping Date", ShipDate);
            RecpDate := GetValueAtIndex(RowNo, 8);
            Evaluate(ImportHeadRec."Req. Receipt Date", RecpDate);
            ImportHeadRec.Insert();
        end;

        Rec_ExcelBuffer.Reset();
        Rec_ExcelBuffer.OpenBookStream(NVInStream, 'Sales Order Lines');
        Rec_ExcelBuffer.ReadSheet();
        // Commit();

        Rec_ExcelBuffer.Reset();
        Rec_ExcelBuffer.SetRange("Column No.", 1);
        Rows := Rec_ExcelBuffer.Count;
        //Finding total number of columns to import

        Rec_ExcelBuffer.Reset();

        Rec_ExcelBuffer.SetRange("Row No.", 1);

        if Rec_ExcelBuffer.FindFirst() then begin
            repeat

                Columns := Columns + 1;

            until Rec_ExcelBuffer.Next() = 0;
        end;

        for RowNo := 3 to Rows do begin
            Clear(ImportLineRec);
            //Message(GetValueAtIndex(RowNo, 1));
            ImportLineRec.Init;
            Evaluate(ImportLineRec."Line No.", GetValueAtIndex(RowNo, 1));
            ImportLineRec."Order No." := GetValueAtIndex(RowNo, 2);
            ImportLineRec."Item No." := GetValueAtIndex(RowNo, 3);
            Evaluate(ImportLineRec.Quantity, GetValueAtIndex(RowNo, 4));
            ImportLineRec.Warehouse := GetValueAtIndex(RowNo, 5);
            ImportLineRec.Insert();
        end;
        Message('Import Completed');
    end;

    local procedure GetValueAtIndex(RowNo: Integer; ColNo: Integer): Text
    var
        Rec_ExcelBuffer: Record "Excel Buffer";
    begin

        Rec_ExcelBuffer.Reset();

        If Rec_ExcelBuffer.Get(RowNo, ColNo) then
            exit(Rec_ExcelBuffer."Cell Value as Text");

    end;

    var

        Rec_ExcelBuffer: Record "Excel Buffer";
        Rows: Integer;
        Columns: Integer;
        Sheetname: Text;
        UploadResult: Boolean;
        DialogCaption: Text;
        Name: Text;
        NVInStream: InStream;
        RowNo: Integer;
        TxtDate: Text;
        DocumentDate: Date;

}

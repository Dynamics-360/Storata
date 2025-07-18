codeunit 50850 Processing
{

    procedure CreateSalesHead()
    var
        ImportHeaderRec: Record "50850_TabImportSalesHeader";
    begin
        ImportHeaderRec.Reset();
        ImportHeaderRec.SetRange(Created, false);
        if ImportHeaderRec.FindSet() then begin
            repeat
                if not CreateOrderHeader(ImportHeaderRec) then begin
                    ImportHeaderRec.Created := false;
                    ImportHeaderRec."Error Description" := GetLastErrorText;
                    ImportHeaderRec.Modify();
                end;
            until ImportHeaderRec.Next() = 0;
        end;
    end;

    procedure CreateSalesLines()
    var
        ImportLinesRec: Record "50851_TabImportSalesLines";
        Process: Codeunit Processing;
    begin
        ImportLinesRec.Reset();
        ImportLinesRec.SetRange(Created, false);
        if ImportLinesRec.FindSet() then begin
            repeat
                if not InsertOrderLines(ImportLinesRec) then begin
                    ImportLinesRec.Created := false;
                    ImportLinesRec."Error Description" := GetLastErrorText;
                    ImportLinesRec.Modify();
                end;
            until ImportLinesRec.Next() = 0;
        end;
    end;

    [TryFunction]
    local procedure CreateOrderHeader(ImportHead: Record "50850_TabImportSalesHeader")
    var
        ImportSalesLines: Record "50851_TabImportSalesLines";
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
            Error('Sales Order no %1 already exist.', ImportHead."Order No.");

        SalesHeader.Init();
        SalesHeader."No." := ImportHead."Order No.";
        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.Validate("Sell-to Customer No.", ImportHead."Customer No.");
        SalesHeader.Validate("External Document No.", ImportHead."Order Reference");
        SalesHeader.Validate("Location Code", ImportHead.Location);
        SalesHeader.Validate("Shipment Method Code", ImportHead."Delivery Mode");
        SalesHeader.Validate("Run No.", ImportHead."Run Number");
        SalesHeader.Validate("Requested Delivery Date", ImportHead."Req. Receipt Date");
        SalesHeader.Validate("Shipment Date", ImportHead."Shipping Date");
        if SalesHeader.Insert() then begin
            ImportHead.Created := true;
            ImportHead.Modify();
        end
        else
            Error(GetLastErrorText);
    end;

    [TryFunction]
    local procedure InsertOrderLines(ImportSalesLines: Record "50851_TabImportSalesLines")
    var
        SalesLine: Record "Sales Line";
        SalesHead: Record "Sales Header";
    begin
        SalesHead.Reset();
        SalesHead.SetRange("Document Type", SalesHead."Document Type"::Order);
        SalesHead.SetRange("No.", ImportSalesLines."Order No.");
        if not SalesHead.FindFirst() then
            Error('Sales Header %1 not created for this line', ImportSalesLines."Order No.");

        SalesLine.Init();
        SalesLine.Validate("Document Type", SalesHead."Document Type");
        SalesLine."Document No." := ImportSalesLines."Order No.";
        SalesLine."Line No." := ImportSalesLines."Line No.";
        SalesLine.Insert();
        SalesLine.Validate("Sell-to Customer No.", SalesHead."Sell-to Customer No.");
        SalesLine.Validate(Type, SalesLine.Type::Item);
        SalesLine.SetHideValidationDialog(true);
        SalesLine.Validate("No.", ImportSalesLines."Item No.");
        SalesLine.Validate(Quantity, ImportSalesLines.Quantity);
        SalesLine.Validate("Location Code", ImportSalesLines.Location);
        if SalesLine.Modify() then begin
            ImportSalesLines.Created := true;
            ImportSalesLines.Modify();
        end;
    end;

    procedure UpdateStockUsingItemJournal(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        EggExpCost: Record "Egg Expected Cost";
        ItemJnlLines: Record "Item Journal Line";
        DimValues: array[8] of Code[20];
        LineNo: Integer;
    begin
        SalesLine.Reset();
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.FindSet() then begin
            repeat
                SalesLine.ShowShortcutDimCode(DimValues);
                EggExpCost.Reset();
                EggExpCost.SetRange("Item No.", SalesLine."No.");
                EggExpCost.SetRange("Farming Method", DimValues[7]);
                EggExpCost.SetRange("Grading Floor", SalesLine."Location Code");
                if EggExpCost.FindFirst() then begin
                    ItemJnlLines.Init();
                    ItemJnlLines.Validate("Journal Template Name", 'ITEM');
                    ItemJnlLines.Validate("Journal Batch Name", 'DEFAULT');
                    LineNo := GetItemJnlLastLineNo(ItemJnlLines."Journal Batch Name", ItemJnlLines."Journal Template Name") + 10000;
                    ItemJnlLines.Validate("Line No.", LineNo);
                    ItemJnlLines.Validate("Item No.", SalesLine."No.");
                    ItemJnlLines.Validate("Location Code", SalesLine."Location Code");
                    ItemJnlLines.ValidateShortcutDimCode(1, DimValues[1]);
                    ItemJnlLines.ValidateShortcutDimCode(2, DimValues[2]);
                    ItemJnlLines.ValidateShortcutDimCode(3, DimValues[3]);
                    ItemJnlLines.ValidateShortcutDimCode(4, DimValues[4]);
                    ItemJnlLines.ValidateShortcutDimCode(5, DimValues[5]);
                    ItemJnlLines.ValidateShortcutDimCode(6, DimValues[6]);
                    ItemJnlLines.ValidateShortcutDimCode(7, DimValues[7]);
                    ItemJnlLines.ValidateShortcutDimCode(8, DimValues[8]);
                    ItemJnlLines.Validate(Quantity, SalesLine.Quantity);
                    ItemJnlLines.Validate("Unit Cost", EggExpCost."Upgraded per Egg Cost" + EggExpCost."Packaging per Egg Cost" + EggExpCost."Grading Overheads per Egg Cost");
                    ItemJnlLines.Insert();
                end;
            until SalesLine.Next() = 0;
        end;

    end;

    local procedure GetItemJnlLastLineNo(ItemJnlBatch: Code[20]; ItemJnlTemplate: code[20]): Integer
    var
        ItemJnlLines: Record "Item Journal Line";
    begin
        ItemJnlLines.Reset();
        ItemJnlLines.SetRange("Journal Template Name", ItemJnlTemplate);
        ItemJnlLines.SetRange("Journal Batch Name", ItemJnlBatch);
        if ItemJnlLines.FindLast() then
            exit(ItemJnlLines."Line No.")
        else
            exit(0);
    end;

    procedure ImportDataFromExcel()
    var
        ImportHeadRec: Record "50850_TabImportSalesHeader";
        ImportLineRec: Record "50851_TabImportSalesLines";
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
            ImportHeadRec.Location := GetValueAtIndex(RowNo, 4);
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
            ImportLineRec.Location := GetValueAtIndex(RowNo, 5);
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

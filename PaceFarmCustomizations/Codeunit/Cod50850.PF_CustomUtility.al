codeunit 50850 PF_CustomUtility
{


    procedure CreateSalesHead()
    var
        ImportHeaderRec: Record "PF_ImportSalesHeader";
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
        ImportLinesRec: Record "PF_ImportSalesLines";
        CustomUtility: Codeunit PF_CustomUtility;
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
    local procedure CreateOrderHeader(ImportHead: Record "PF_ImportSalesHeader")
    var
        ImportSalesLines: Record "PF_ImportSalesLines";
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
    local procedure InsertOrderLines(ImportSalesLines: Record "PF_ImportSalesLines")
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
        EggExpCost: Record "PF_Egg Expected Cost";
        ItemJnlLines: Record "Item Journal Line";
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlTemplate: Record "Item Journal Template";
        PostItemJnl: Codeunit "Item Jnl.-Post Line";
        NoSeries: Codeunit "No. Series";
        DocumentNo: Code[20];
        DimValues: array[8] of Code[20];
        LineNo: Integer;
    begin
        ItemJnlLines.LockTable(true);
        if ItemJnlBatch.Get('ITEM', 'GRADING') then
            DocumentNo := NoSeries.GetNextNo(ItemJnlBatch."No. Series");
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
                    ItemJnlLines.Validate("Journal Batch Name", 'GRADING');
                    LineNo := GetItemJnlLastLineNo(ItemJnlLines."Journal Batch Name", ItemJnlLines."Journal Template Name") + 10000;
                    ItemJnlLines.Validate("Line No.", LineNo);
                    ItemJnlLines.Validate("Posting Date", Today);
                    ItemJnlLines.Validate("Item No.", SalesLine."No.");
                    ItemJnlLines.Validate("Document No.", DocumentNo);
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
                    ItemJnlLines.Validate("Unit Amount", EggExpCost."Ungraded per Egg Cost" + EggExpCost."Packaging per Egg Cost" + EggExpCost."Grading Overheads per Egg Cost");
                    if ItemJnlLines.Insert() then;
                    // ItemJnlLines.Mark(true)
                end;
            until SalesLine.Next() = 0;
        end;

        ItemJnlLines.Reset();
        ItemJnlLines.SetRange("Journal Template Name", 'ITEM');
        ItemJnlLines.SetRange("Journal Batch Name", 'GRADING');
        // ItemJnlLines.MarkedOnly(true);
        if ItemJnlLines.IsEmpty() then
            Error('No Item Journal Lines created for Sales Order %1', SalesHeader."No.")
        else
            Message('Stocks are created for Sales Order %1 in Item Journal successfuly', SalesHeader."No.");

        ItemJnlLines.RenumberDocumentNo();
        if Confirm('Do you want to post the Item Journal?', false) then
            // PostItemJnl.RunWithCheck(ItemJnlLines);
            Codeunit.Run(Codeunit::"Item Jnl.-Post", ItemJnlLines)
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
        ImportHeadRec: Record "PF_ImportSalesHeader";
        ImportLineRec: Record "PF_ImportSalesLines";
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

    procedure CheckCreditLimit(SalesHeader: Record "Sales Header")
    var
        Customer: Record Customer;
        UserSetup: Record "User Setup";
    begin
        if not Customer.Get(SalesHeader."Sell-to Customer No.") then
            Error('Customer %1 does not exist.', Customer."No.");

        if Customer."Credit Limit (LCY)" <= 0 then
            exit;

        Customer.CalcFields("Balance (LCY)");
        if Customer."Credit Limit (LCY)" < Customer."Balance (LCY)" then
            Error('You can''t post the order because customer %1 already have the balance of %2', Customer."No.", Customer."Balance (LCY)");

        if Customer."Credit Limit (LCY)" < Customer."Balance (LCY)" + SalesHeader."Amount Including VAT" then begin
            if not UserSetup.Get(UserId()) then
                Error('User setup for user %1 does not exist for Credit Limit setup.', UserId());

            if not UserSetup."Sales Limit Override" then
                Error('You can''t post the order because you don''t have the permission to Ovveride the Credit Limit', Customer."No.", Customer."Balance (LCY)");
        end;
    end;

    procedure ShowMsgForSandbox()
    var
        Environemtn: Codeunit "Environment Information";
    begin
        if Environemtn.IsSandbox() then
            Message('PLEASE NOTE: You are in the test system');
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

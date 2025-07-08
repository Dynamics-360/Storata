codeunit 50850 Processing
{

    procedure CreateSalesHead(var ImportHeader: Record "50850_TabImportSalesHeader")
    begin
        if ImportHeader.FindSet() then begin
            repeat
                if not CreateOrderHeader(ImportHeader) then begin
                    ImportHeader.Created := false;
                    ImportHeader."Error Description" := GetLastErrorText;
                    ImportHeader.Modify();
                end;
            until ImportHeader.Next() = 0;
        end;
    end;

    procedure CreateSalesLines(var ImportLines: Record "50851_TabImportSalesLines")
    begin
        if ImportLines.FindSet() then begin
            repeat
                if not InsertOrderLines(ImportLines) then begin
                    ImportLines.Created := false;
                    ImportLines."Error Description" := GetLastErrorText;
                    ImportLines.Modify();
                end;
            until ImportLines.Next() = 0;
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
            // ImportSalesLines.Reset();
            // ImportSalesLines.SetRange("Order No.", ImportHead."Order No.");
            // ImportSalesLines.SetRange(Created, false);
            // if ImportSalesLines.FindSet() then
            //     CreateLines(SalesHeader, ImportSalesLines);
        end
        else
            Error(GetLastErrorText);
    end;

    [TryFunction]
    local procedure InsertOrderLines(var ImportSalesLines: Record "50851_TabImportSalesLines")
    var
        SalesLine: Record "Sales Line";
        SalesHead: Record "Sales Header";
    begin
        SalesHead.Reset();
        SalesHead.SetRange("Document Type", SalesHead."Document Type"::Order);
        SalesHead.SetRange("No.", ImportSalesLines."Order No.");
        if SalesHead.FindFirst() then
            Error('Sales Header %1 not created for this line', ImportSalesLines."Order No.");

        if ImportSalesLines.FindSet() then begin
            repeat
                Clear(SalesLine);
                SalesLine.init();
                SalesLine.Validate("Document Type", SalesLine."Document Type");
                SalesLine.Validate("Document No.", ImportSalesLines."Order No.");
                SalesLine."Line No." := ImportSalesLines."Line No.";
                SalesLine.Validate(Type, SalesLine.Type::Item);
                SalesLine.Validate("No.", ImportSalesLines."Item No.");
                SalesLine.Validate(Quantity, ImportSalesLines.Quantity);
                SalesLine.Validate("Location Code", ImportSalesLines.Location);
                if SalesLine.Insert() then begin
                    ImportSalesLines.Created := true;
                    ImportSalesLines.Modify();
                end;
            until ImportSalesLines.Next() = 0;
        end;
    end;
}

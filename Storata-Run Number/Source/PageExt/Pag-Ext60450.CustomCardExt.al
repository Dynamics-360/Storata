pageextension 60450 CustomCardExt extends "Customer Card"
{
    PromotedActionCategories = ',,,,,,,,,,Run Process';
    layout
    {
        addafter("Address & Contact")
        {
            group("Customer SKU's")
            {
                part(CustomSKU; "Customer SKU")
                {
                    Caption = ' ';
                    ApplicationArea = All;
                    SubPageLink = "Customer No." = field("No.");
                    UpdatePropagation = Both;
                }
            }
            group("Customer Runs")
            {
                part(CustomRuns; "Customer Runs")
                {
                    Caption = ' ';
                    ApplicationArea = All;
                    Editable = true;
                    SubPageLink = "Customer No." = field("No.");
                    UpdatePropagation = Both;
                }
            }
        }
    }
    actions
    {
        modify(NewSalesOrder)
        {
            Visible = false;
        }
        addafter(NewSalesOrder)
        {
            group(Process)
            {
                Caption = 'Process';
                action("Create Sales Order")
                {
                    ApplicationArea = All;
                    Image = Document;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category11;

                    trigger OnAction()
                    begin
                        CreateOrder();
                    end;
                }
                action("Update Run Date")
                {
                    ApplicationArea = All;
                    Image = ChangeDate;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category11;

                    trigger OnAction()
                    var
                        UpdateCallsDate: Codeunit "Update Calls";
                        CallSheet: Report "Update Call Sheet";
                    begin
                        UpdateCallsDate.CalcUpdateCalls();
                        Commit();
                        CallSheet.Run();
                    end;
                }

            }
        }
    }
    local procedure CreateOrder()
    var
        SalesHead: Record "Sales Header";
        SalesLine: Record "Sales Line";
        CustomerSku: Record "Customer SKU";
        CustRun: Record "Customer Runs";
        SalesLinesTemp: Record "Sales Line" temporary;
        SalesOrderPag: Page "Sales Order";
        Count: Integer;
        LineNo: Integer;
    begin
        if not ShowDefaultSKU() then
            exit;

        Count := 0;
        CustRun.Reset();
        CustRun.SetRange("Customer No.", Rec."No.");
        if CustRun.FindFirst() then begin
            repeat
                Clear(SalesHead);
                Clear(SalesLine);
                Clear(LineNo);
                SalesHead.Init();
                SalesHead.validate("Document Type", SalesHead."Document Type"::Order);
                SalesHead.Validate("Sell-to Customer No.", Rec."No.");
                SalesHead.Validate("Bill-to Customer No.", Rec."No.");
                SalesHead.validate("Document Date", Today);
                SalesHead.Validate("Run No.", CustRun."Run No");
                if SalesHead.Insert(true) then begin
                    Count += 1;
                    SKUBuffer.Reset();
                    SKUBuffer.SetFilter(Quantity, '>0');
                    if SKUBuffer.FindFirst() then begin
                        repeat
                            SalesLine.Init;
                            SalesLine.validate("Document Type", SalesLine."Document Type"::Order);
                            SalesLine.Validate("Document No.", SalesHead."No.");
                            LineNo += 10000;
                            SalesLine.validate("Line No.", LineNo);
                            SalesLine.Validate(Type, SalesLine.Type::Item);
                            SalesLine.Validate("No.", SKUBuffer."Item No.");
                            SalesLine.Validate(Quantity, SKUBuffer.Quantity);
                            SalesLine.Validate("Run No.", CustRun."Run No");
                            SalesLine.Insert();
                        until SKUBuffer.Next() = 0;
                    end;
                end;
            // Commit();
            until CustRun.Next() = 0;
        end;
        if Count > 0 then
            Message('%1 order created for Customer %2', Count, Rec."No.");
    end;

    local procedure ShowDefaultSKU(): Boolean
    var
        CustomerSku: Record "Customer SKU";
        CustomSkUPag: Page CustomerSKUBuffer;
    begin
        SKUBuffer.DeleteAll();
        CustomerSku.Reset();
        CustomerSku.SetRange("Customer No.", Rec."No.");
        if CustomerSku.FindSet() then begin
            repeat
                SKUBuffer.Init();
                SKUBuffer."Item No." := CustomerSku."Item No.";
                SKUBuffer.Desciption := CustomerSku.Desciption;
                SKUBuffer.Insert();
            until CustomerSku.Next() = 0;
        end;
        Commit();
        if SKUBuffer.FindSet() then begin
            CustomSkUPag.SetRecord(SKUBuffer);
            CustomSkUPag.LookupMode(true);
            CustomSkUPag.Editable(true);
            if CustomSkUPag.RunModal() = Action::LookupOK then
                exit(true)
            else
                exit(false);
        end;
    end;

    var
        SKUBuffer: Record DefaultSKUBuffer;
}

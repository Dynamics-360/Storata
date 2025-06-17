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
                    var
                        SalesHead: Record "Sales Header";
                        SalesLine: Record "Sales Line";
                        CustomerSku: Record "Customer SKU";
                        CustRun: Record "Customer Runs";
                        SalesOrderPag: Page "Sales Order";
                        LineNo: Integer;
                        Count: Integer;
                    begin
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
                                    CustomerSku.Reset();
                                    CustomerSku.SetRange("Customer No.", Rec."No.");
                                    if CustomerSku.FindFirst() then begin
                                        repeat
                                            SalesLine.Init;
                                            LineNo += 10000;
                                            SalesLine.validate("Document Type", SalesLine."Document Type"::Order);
                                            SalesLine.Validate("Document No.", SalesHead."No.");
                                            SalesLine.validate("Line No.", LineNo);
                                            SalesLine.Validate(Type, SalesLine.Type::Item);
                                            SalesLine.Validate("No.", CustomerSku."Item No.");
                                            SalesLine.Validate(Quantity, CustomerSku.Quantity);
                                            SalesLine.Insert();
                                        until CustomerSku.Next() = 0;
                                    end;
                                end;
                            // Commit();
                            until CustRun.Next() = 0;
                        end;
                        if Count > 0 then
                            Message('%1 order created for Customer %2', Count, Rec."No.");
                    end;
                }
                action("Update Run Date")
                {
                    ApplicationArea = All;
                    Image = ChangeDate;
                    trigger OnAction()
                    var
                        UpdateCall: Codeunit "Update Calls";
                    begin
                        UpdateCall.CalcUpdateCalls();
                    end;
                }

            }
        }
    }
}

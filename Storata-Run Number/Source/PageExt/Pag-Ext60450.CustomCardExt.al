pageextension 60450 CustomCardExt extends "Customer Card"
{
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
            action("Create Sales Order")
            {
                ApplicationArea = All;
                Image = Document;
                Promoted = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    SalesHead: Record "Sales Header";
                    SalesLine: Record "Sales Line";
                    CustomerSku: Record "Customer SKU";
                    SalesOrderPag: Page "Sales Order";
                    LineNo: Integer;
                begin
                    SalesHead.Init();
                    SalesHead.validate("Document Type", SalesHead."Document Type"::Order);
                    SalesHead.Validate("Sell-to Customer No.", Rec."No.");
                    SalesHead.Validate("Bill-to Customer No.", Rec."No.");
                    SalesHead.validate("Document Date", Today);
                    if SalesHead.Insert(true) then begin
                        Commit();
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

                    if SalesHead."No." <> '' then begin
                        SalesOrderPag.SetRecord(SalesHead);
                        SalesOrderPag.Run();
                    end;
                end;
            }
        }
    }
}

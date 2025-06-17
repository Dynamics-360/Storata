page 60453 "Call Sheet"
{
    ApplicationArea = All;
    Caption = 'Call Sheet';
    PageType = List;
    SourceTable = "Customer Runs";
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
                }
                field("Customer State"; Rec."Customer State")
                {
                    ToolTip = 'Specifies the value of the Customer State field.', Comment = '%';
                }
                field("Run No"; Rec."Run No")
                {
                    ToolTip = 'Specifies the value of the Run No field.', Comment = '%';
                }
                field("Run Day"; Rec."Run Day")
                {
                    ToolTip = 'Specifies the value of the Run Day field.', Comment = '%';
                }
                field("Run Date"; Rec."Run Date")
                {
                    ToolTip = 'Specifies the value of the Run Date field.', Comment = '%';
                }
                field("Call Day"; Rec."Call Day")
                {
                    ToolTip = 'Specifies the value of the Call Day field.', Comment = '%';
                }
                field("Call Date"; Rec."Call Date")
                {
                    ToolTip = 'Specifies the value of the Call Date field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Customer)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Customer;
                trigger OnAction()
                var
                    Customer: Record Customer;
                    CustomerCard: Page "Customer Card";
                begin
                    if Customer.Get(Rec."Customer No.") then begin
                        CustomerCard.SetRecord(Customer);
                        CustomerCard.Run();
                    end;
                end;
            }
            action("Create Sales Order")
            {
                ApplicationArea = All;
                Image = Document;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesHead: Record "Sales Header";
                    SalesLine: Record "Sales Line";
                    CustomerSku: Record "Customer SKU";
                    SalesOrderPag: Page "Sales Order";
                    LineNo: Integer;
                begin
                    Clear(SalesHead);
                    Clear(SalesLine);
                    Clear(LineNo);
                    SalesHead.Init();
                    SalesHead.validate("Document Type", SalesHead."Document Type"::Order);
                    SalesHead.Validate("Sell-to Customer No.", Rec."Customer No.");
                    SalesHead.Validate("Bill-to Customer No.", Rec."Customer No.");
                    SalesHead.validate("Document Date", Today);
                    SalesHead.Validate("Run No.", Rec."Run No");
                    if SalesHead.Insert(true) then begin
                        CustomerSku.Reset();
                        CustomerSku.SetRange("Customer No.", Rec."Customer No.");
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
                    Message('Order created for Customer %1', Rec."Customer No.");
                end;
            }

        }
    }
    trigger OnAfterGetRecord()
    var
        Customer: Record Customer;
    begin
        if Customer.Get(Rec."Customer No.") then begin
            Rec."Customer Name" := Customer.Name;
            Rec."Customer State" := Customer.County;
            Rec.Modify();
        end;
    end;

}

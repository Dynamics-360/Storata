page 60453 "Call Sheet"
{
    ApplicationArea = All;
    Caption = 'Call Sheet';
    PageType = List;
    SourceTable = "Customer Runs";
    UsageCategory = Lists;

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
        }
    }
}

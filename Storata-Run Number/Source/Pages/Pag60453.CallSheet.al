page 60453 "Call Sheet"
{
    ApplicationArea = All;
    Caption = 'Call Sheet';
    PageType = List;
    SourceTable = "Call Sheet";
    UsageCategory = Lists;
    Editable = true;
    InsertAllowed = false;
    DeleteAllowed = true;

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
                field("Call Group"; Rec."Call Group")
                {
                    ToolTip = 'Specifies the value of the Call Group field.', Comment = '%';
                }
                field("Call Date"; Rec."Call Date")
                {
                    ToolTip = 'Specifies the value of the Call Date field.', Comment = '%';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
                field(Called; Rec.Called)
                {
                    ToolTip = 'Specifies the value of the Called field.', Comment = '%';
                }
                field("Call Back"; Rec."Call Back")
                {
                    ToolTip = 'Specifies the value of the Call Back field.', Comment = '%';
                }
                field(Closed; Rec.Closed)
                {
                    ToolTip = 'Specifies the value of the Closed field.', Comment = '%';
                }
                field(Holidays; Rec.Holidays)
                {
                    ToolTip = 'Specifies the value of the Holidays field.', Comment = '%';
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
                    Customer: Record Customer;
                    CustRun: Record "Customer Runs";
                    CallSheet: Record "Call Sheet";
                    Run: Record "Runs";
                    RunMgt: Codeunit "Run Number Mgt.";
                begin
                    if Customer.Get(Rec."Customer No.") then
                        if CustRun.Get(Rec."Customer No.", Rec."Run No") then
                            RunMgt.CreateOrder(Customer, CustRun);
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

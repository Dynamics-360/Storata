page 60457 "Customer Runs List"
{
    ApplicationArea = All;
    Caption = 'Customer Runs';
    PageType = List;
    SourceTable = "Customer Runs";
    Editable = true;
    UsageCategory = Administration;

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
                field("Drop No"; Rec."Drop No")
                {
                    ToolTip = 'Show the value of the Drop No. field.', Comment = '%';
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
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
                }
                field("Customer State"; Rec."Customer State")
                {
                    ToolTip = 'Specifies the value of the Customer State field.', Comment = '%';
                }
                field("Call Group"; Rec."Call Group")
                {
                    ToolTip = 'Specifies the value of the Call Group field.', Comment = '%';
                }
                field(Holidays; Rec.Holidays)
                {
                    ToolTip = 'Specifies the value of the Holidays field.', Comment = '%';
                }
            }
        }
    }
}

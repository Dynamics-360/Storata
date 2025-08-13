page 50853 "Warehouse Supervisor"
{
    ApplicationArea = All;
    Caption = 'Warehouse Supervisor';
    PageType = List;
    SourceTable = "Warehouse Supervisor";
    UsageCategory = Administration;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Supervisor No."; Rec."Supervisor No.")
                {
                    ToolTip = 'Specifies the value of the Supervisor No. field.', Comment = '%';
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    ToolTip = 'Specifies the value of the Supervisor Name field.', Comment = '%';
                }
                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies the value of the Active field.', Comment = '%';
                }
            }
        }
    }
}

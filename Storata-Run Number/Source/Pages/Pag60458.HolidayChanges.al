page 60458 "Holiday Changes"
{
    ApplicationArea = All;
    Caption = 'Holiday Changes';
    PageType = List;
    SourceTable = "Holiday Changes";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Run No"; Rec."Run No")
                {
                    ToolTip = 'Specifies the value of the Run No field.', Comment = '%';
                }
                field("Date to be Replaced"; Rec."Date to be Replaced")
                {
                    ToolTip = 'Specifies the value of the Date to be Replaced field.', Comment = '%';
                }
                field("New Date"; Rec."New Date")
                {
                    ToolTip = 'Specifies the value of the New Date field.', Comment = '%';
                }
            }
        }
    }
}

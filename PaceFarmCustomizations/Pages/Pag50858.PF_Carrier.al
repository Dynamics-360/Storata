page 50858 Carrier
{
    ApplicationArea = All;
    Caption = 'Carrier';
    PageType = List;
    SourceTable = Carrier;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Carrier No."; Rec."Carrier No.")
                {
                    ToolTip = 'Specifies the value of the Carrier No. field.', Comment = '%';
                }
                field("Carrier Name"; Rec."Carrier Name")
                {
                    ToolTip = 'Specifies the value of the Carrier Name field.', Comment = '%';
                }
                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies the value of the Active field.', Comment = '%';
                }
            }
        }
    }
}

page 50857 Storeman
{
    ApplicationArea = All;
    Caption = 'Storeman';
    PageType = List;
    SourceTable = Storeman;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Storeman No."; Rec."Storeman No.")
                {
                    ToolTip = 'Specifies the value of the Storeman No. field.', Comment = '%';
                }
                field("Storeman Name"; Rec."Storeman Name")
                {
                    ToolTip = 'Specifies the value of the Storeman Name field.', Comment = '%';
                }
                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies the value of the Active field.', Comment = '%';
                }
            }
        }
    }
}

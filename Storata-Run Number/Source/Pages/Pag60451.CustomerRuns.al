page 60451 "Customer Runs"
{
    ApplicationArea = All;
    PageType = ListPart;
    MultipleNewLines = true;
    SourceTable = "Customer Runs";
    DelayedInsert = true;
    AutoSplitKey = false;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Run No"; Rec."Run No")
                {
                    ToolTip = 'Specifies the value of the Run No field.', Comment = '%';

                    trigger OnValidate()
                    var
                        Run: Record Runs;
                    begin
                        if Run.Get(Rec."Run No") then
                            Rec."Run Day" := Run.Weekdays;
                    end;
                }
                field("Run Day"; Rec."Run Day")
                {
                    ToolTip = 'Specifies the value of the Run Day field.', Comment = '%';
                    Editable = false;
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
                field(Holidays; Rec.Holidays)
                {
                    ToolTip = 'Specifies the value of the Holidays field.', Comment = '%';
                }
            }
        }
    }
}

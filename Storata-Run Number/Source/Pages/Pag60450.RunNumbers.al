page 60450 "Run Numbers"
{
    ApplicationArea = All;
    Caption = 'Run Numbers';
    PageType = List;
    SourceTable = Runs;
    MultipleNewLines = true;
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
                field(Warehouse; Rec.Warehouse)
                {
                    ToolTip = 'Specifies the value of the Warehouse field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Specifies the value of the Description 2 field.', Comment = '%';
                }
                field(Weekdays; Rec.Weekdays)
                {
                    ToolTip = 'Specifies the value of the Weekdays field.', Comment = '%';
                }
                field(Calender; Rec.Calender)
                {
                    ToolTip = 'Specifies the value of the Calender field.', Comment = '%';
                }
                field("Lead Time"; Rec."Lead Time")
                {
                    ToolTip = 'Specifies the value of the Lead Time field.', Comment = '%';
                }
                field("Call Day"; Rec."Call Day")
                {
                    ToolTip = 'Specifies the value of the Call Day field.', Comment = '%';
                }
                field(Inactive; Rec.Inactive)
                {
                    ToolTip = 'Specifies the value of the Inactive field.', Comment = '%';
                }
            }
        }
    }
}

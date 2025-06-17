page 60454 "Run Numbers List"
{
    ApplicationArea = All;
    Caption = 'Run Numbers List';
    PageType = List;
    SourceTable = Runs;

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
                field("Warehouse Name"; Rec."Warehouse Name")
                {
                    ToolTip = 'Specifies the value of the Warehouse Name field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
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
                field(Inactive; Rec.Inactive)
                {
                    ToolTip = 'Specifies the value of the Inactive field.', Comment = '%';
                }
            }
        }
    }
}

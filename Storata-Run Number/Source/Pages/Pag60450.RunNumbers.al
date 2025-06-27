page 60450 "Run Numbers"
{
    ApplicationArea = All;
    Caption = 'Run Numbers';
    PageType = List;
    SourceTable = Runs;
    MultipleNewLines = true;
    AutoSplitKey = false;
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
                    trigger OnValidate()
                    var
                        Location: Record Location;
                    begin
                        if Location.Get(Rec.Warehouse) then begin
                            Rec."Warehouse Name" := Location.Name;
                            Rec.Modify();
                        end;
                    end;
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

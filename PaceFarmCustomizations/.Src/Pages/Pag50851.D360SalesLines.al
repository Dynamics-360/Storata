page 50851 "Import Sales Lines"
{
    ApplicationArea = All;
    Caption = 'Import Sales Lines';
    PageType = ListPart;
    MultipleNewLines = true;
    SourceTable = "Import Sales Lines";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Order No."; Rec."Order No.")
                {
                    ToolTip = 'Specifies the value of the Order No. field.', Comment = '%';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field(Warehouse; Rec.Warehouse)
                {
                    ToolTip = 'Specifies the value of the Warehouse field.', Comment = '%';
                }
                field(Created; Rec.Created)
                {
                    ToolTip = 'Specifies the value of the Created field.', Comment = '%';
                }
            }
        }
    }
}

page 60452 "Customer SKU"
{
    ApplicationArea = All;
    PageType = ListPart;
    AutoSplitKey = false;
    MultipleNewLines = true;
    SourceTable = "Customer SKU";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.', Comment = '%';
                }
                field(Desciption; Rec.Desciption)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Item UOM"; Rec."Item UOM")
                {
                    ToolTip = 'Specifies the value of the Item UOM field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
            }
        }
    }
}

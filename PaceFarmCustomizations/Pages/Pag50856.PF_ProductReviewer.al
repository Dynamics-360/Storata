page 50856 "Product Reviewer"
{
    ApplicationArea = All;
    Caption = 'Product Reviewer';
    PageType = List;
    SourceTable = "Product Reviewer";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Product Reviewer No."; Rec."Product Reviewer No.")
                {
                    ToolTip = 'Specifies the value of the Product Reviewer No. field.', Comment = '%';
                }
                field("Product Reviewer Name"; Rec."Product Reviewer Name")
                {
                    ToolTip = 'Specifies the value of the Product Reviewer Name field.', Comment = '%';
                }
                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies the value of the Active field.', Comment = '%';
                }
            }
        }
    }
}

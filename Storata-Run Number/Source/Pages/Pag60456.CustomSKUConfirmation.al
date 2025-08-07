page 60456 CustomerSKUBuffer
{
    ApplicationArea = All;
    Caption = 'Customer SKU Confirmation';
    PageType = List;
    SourceTable = DefaultSKUBuffer;
    UsageCategory = None;

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
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        CurrPage.Editable(true);
    end;
}

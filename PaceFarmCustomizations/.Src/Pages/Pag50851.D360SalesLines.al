page 50851 "50851_PagImportSalesLines"
{
    ApplicationArea = All;
    Caption = 'Import Sales Lines';
    PageType = ListPart;
    MultipleNewLines = true;
    SourceTable = "50851_TabImportSalesLines";

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
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field.', Comment = '%';
                }
                field(Created; Rec.Created)
                {
                    ToolTip = 'Specifies the value of the Created field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Delete")
            {
                ApplicationArea = All;
                Image = Delete;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ImportLinesRec: Record "50851_TabImportSalesLines";
                begin
                    CurrPage.SetSelectionFilter(ImportLinesRec);
                    if ImportLinesRec.FindSet() then
                        ImportLinesRec.DeleteAll();
                end;
            }
        }
    }
}

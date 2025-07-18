page 50851 "50851_PagImportSalesLines"
{
    ApplicationArea = All;
    Caption = 'Import Sales Lines';
    PageType = ListPart;
    MultipleNewLines = true;
    SourceTable = "50851_TabImportSalesLines";
    DeleteAllowed = true;

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
                field("Error Description"; Rec."Error Description")
                {
                    ToolTip = 'Specifies the value of the Error Description field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Process Lines")
            {
                ApplicationArea = All;
                Image = Process;
                // Promoted = true;
                // PromotedOnly = true;
                // PromotedCategory = Process;

                trigger OnAction()
                var
                    Process: Codeunit Processing;
                begin
                    Process.CreateSalesLines();
                    CurrPage.Update();
                end;
            }
            action("Delete Created")
            {
                ApplicationArea = All;
                Image = Delete;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ImportLinesRec: Record "50851_TabImportSalesLines";
                    DeleteCreatedLbl: Text;
                begin
                    ImportLinesRec.Reset();
                    ImportLinesRec.SetRange(Created, true);
                    DeleteCreatedLbl := StrSubstNo('Are you sure you want to delete %1 created lines.', ImportLinesRec.Count);
                    if Confirm(DeleteCreatedLbl, true) then
                        ImportLinesRec.DeleteAll();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange(Created, false);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ImportSalesLines: Record "50851_TabImportSalesLines";
    begin
        CurrPage.SetSelectionFilter(ImportSalesLines);
        if ImportSalesLines.FindSet() then
            ImportSalesLines.DeleteAll();
    end;
}

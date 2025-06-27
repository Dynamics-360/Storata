page 50850 D360_SalesHeaer
{
    ApplicationArea = All;
    Caption = 'Import Sales Data';
    PageType = Worksheet;
    MultipleNewLines = true;
    SourceTable = "50850_TabImportSalesHeader";
    UsageCategory = Lists;
    AutoSplitKey = false;
    SaveValues = true;

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
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }
                field("Order Reference"; Rec."Order Reference")
                {
                    ToolTip = 'Specifies the value of the Order Reference field.', Comment = '%';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field.', Comment = '%';
                }
                field("Delivery Mode"; Rec."Delivery Mode")
                {
                    ToolTip = 'Specifies the value of the Delivery Mode field.', Comment = '%';
                }
                field("Run Number"; Rec."Run Number")
                {
                    ToolTip = 'Specifies the value of the Run Number field.', Comment = '%';
                }
                field("Shipping Date"; Rec."Shipping Date")
                {
                    ToolTip = 'Specifies the value of the Shipping Date field.', Comment = '%';
                }
                field("Req. Receipt Date"; Rec."Req. Receipt Date")
                {
                    ToolTip = 'Specifies the value of the Req. Receipt Date field.', Comment = '%';

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
            part(D360SalesLines; "50851_PagImportSalesLines")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Create Header")
            {
                ApplicationArea = All;
                Image = MakeOrder;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ImportHeaderRec: Record "50850_TabImportSalesHeader";
                    Process: Codeunit Processing;
                begin
                    CurrPage.SetSelectionFilter(ImportHeaderRec);
                    ImportHeaderRec.SetRange(Created, false);
                    if ImportHeaderRec.FindSet() then begin
                        Process.CreateSalesHead(ImportHeaderRec);
                        CurrPage.Update();
                    end;
                end;
            }
            action("Import Excel")
            {
                ApplicationArea = All;
                Image = Excel;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Process: Codeunit Processing;
                begin
                    Process.ImportDataFromExcel();
                    CurrPage.Update();
                end;
            }
            action("Delete")
            {
                ApplicationArea = All;
                Image = Delete;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ImportHeadRec: Record "50850_TabImportSalesHeader";
                begin
                    CurrPage.SetSelectionFilter(ImportHeadRec);
                    if ImportHeadRec.FindSet() then
                        ImportHeadRec.DeleteAll();
                end;
            }
        }
    }
}

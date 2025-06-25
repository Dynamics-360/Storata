page 50850 D360_SalesHeaer
{
    ApplicationArea = All;
    Caption = 'Import Sales Data';
    PageType = Worksheet;
    MultipleNewLines = true;
    SourceTable = "Import Sales Header";
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
                field(Warehouse; Rec.Warehouse)
                {
                    ToolTip = 'Specifies the value of the Warehouse field.', Comment = '%';
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
            part(D360SalesLines; "Import Sales Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Order No." = field("Order No.");
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Create Order")
            {
                ApplicationArea = All;
                Image = MakeOrder;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ImportHeaderRec: Record "Import Sales Header";
                    Process: Codeunit Processing;
                begin
                    CurrPage.SetSelectionFilter(ImportHeaderRec);
                    if ImportHeaderRec.FindSet() then begin
                        Process.ProcessData(ImportHeaderRec);
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
        }
    }
}

page 50850 "Storata Import Sales Data"
{
    ApplicationArea = All;
    Caption = 'Import Sales Data';
    PageType = Worksheet;
    MultipleNewLines = true;
    SourceTable = "50850_TabImportSalesHeader";
    UsageCategory = Lists;
    AutoSplitKey = false;
    SaveValues = true;
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
            part(StorataalesLines; "Storata Import Sales Lines")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Process Header")
            {
                ApplicationArea = All;
                Image = MakeOrder;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Process: Codeunit Processing;
                begin
                    Process.CreateSalesHead();
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
                    ImportHeadRec: Record "50850_TabImportSalesHeader";
                    DeleteCreatedLbl: Text;
                begin
                    ImportHeadRec.Reset();
                    ImportHeadRec.SetRange(Created, true);
                    DeleteCreatedLbl := StrSubstNo('Are you sure you want to delete %1 created lines.', ImportHeadRec.Count);
                    if Confirm(DeleteCreatedLbl, true) then
                        ImportHeadRec.DeleteAll();
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
        ImportSalesHead: Record "50850_TabImportSalesHeader";
    begin
        CurrPage.SetSelectionFilter(ImportSalesHead);
        if ImportSalesHead.FindSet() then
            ImportSalesHead.DeleteAll();
    end;
}

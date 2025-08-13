pageextension 50864 SalesReceivSetupCardExt extends "Sales & Receivables Setup"
{
    layout
    {
        addlast(content)
        {
            group("Grading Floor")
            {
                field("Item Journal Template"; Rec."Item Journal Template")
                {
                    Caption = 'Item Journal Template';
                    ToolTip = 'Select the Item Journal Template for Grading Floor stock posting';
                    ApplicationArea = All;
                }
                field("Item Journal Batch"; Rec."Item Journal Batch")
                {
                    Caption = 'Item Journal Template';
                    ToolTip = 'Select the Item Journal Batch for Grading Floor stock posting';
                    ApplicationArea = All;
                }
            }
        }
    }
}

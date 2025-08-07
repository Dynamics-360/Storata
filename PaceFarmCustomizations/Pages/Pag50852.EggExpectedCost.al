page 50852 "Storata Egg Expected Cost"
{
    ApplicationArea = All;
    Caption = 'Egg Expected Cost (Graded)';
    PageType = List;
    Editable = true;
    SourceTable = "Storata Egg Expected Cost";
    UsageCategory = Administration;

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
                field("Farming Method"; Rec."Farming Method")
                {
                    ToolTip = 'Specifies the value of the Farming Method field.', Comment = '%';
                }
                field("Grading Floor"; Rec."Grading Floor")
                {
                    ToolTip = 'Specifies the value of the Grading Floor field.', Comment = '%';
                }
                field("Upgraded per Egg Cost"; Rec."Upgraded per Egg Cost")
                {
                    ToolTip = 'Specifies the value of the Upgraded per Egg Cost field.', Comment = '%';
                }
                field("Packaging per Egg Cost"; Rec."Packaging per Egg Cost")
                {
                    ToolTip = 'Specifies the value of the Packaging per Egg Cost field.', Comment = '%';
                }
                field("Grading Overheads per Egg Cost"; Rec."Grading Overheads per Egg Cost")
                {
                    ToolTip = 'Specifies the value of the Grading Overheads per Egg Cost field.', Comment = '%';
                }
            }
        }
    }
}

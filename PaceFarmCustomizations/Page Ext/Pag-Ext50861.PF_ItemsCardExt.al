pageextension 50861 PF_ItemsCard extends "Item Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(VariantMandatoryDefaultNo)
        {
            field("Pick Group"; Rec."Pick Group")
            {
                ApplicationArea = All;

            }
        }
    }
}
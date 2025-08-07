pageextension 50862 PF_SalesOrderSubForm extends "Sales Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("Pick Group"; Rec."Pick Group")
            {
                ApplicationArea = All;
            }
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                ItemRecord: Record Item;
            begin
                if rec.Type = rec.Type::Item then begin
                    if rec."Pick Group" = rec."Pick Group"::" " then begin
                        if ItemRecord.Get(Rec."No.") then begin
                            rec."Pick Group" := ItemRecord."Pick Group";
                            rec.Modify()
                        end;
                    end;
                end;
            end;
        }
    }



}
tableextension 50859 ReturnReciptLines extends "Return Receipt Line"
{
    fields
    {
        field(50860; "Product Relv. Temp."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Product Relevant Temp.';
        }
        field(50861; "Condition on Arrival"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Good,Leaking,Damaged,Soiled;
        }
        field(50862; "Condition Comment"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Condition Comment';
        }
    }
}

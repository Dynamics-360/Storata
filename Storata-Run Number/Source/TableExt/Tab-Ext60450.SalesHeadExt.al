tableextension 60450 SalesHeadExt extends "Sales Header"
{
    fields
    {
        field(60450; "Run No."; Code[20])
        {
            Caption = 'Run No.';
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }
}

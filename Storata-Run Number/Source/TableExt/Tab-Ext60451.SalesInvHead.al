tableextension 60451 SalesInvHead extends "Sales Invoice Header"
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

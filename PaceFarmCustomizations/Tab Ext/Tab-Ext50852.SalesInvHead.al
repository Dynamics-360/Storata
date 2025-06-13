tableextension 50852 SalesInvHead extends "Sales Invoice Header"
{
    fields
    {
        field(50850; SDN; Code[200])
        {
            Caption = 'SDN';
            DataClassification = ToBeClassified;
        }
        field(50851; "Truck Rego"; Code[200])
        {
            Caption = 'Truck Rego';
            DataClassification = ToBeClassified;
        }
    }
}

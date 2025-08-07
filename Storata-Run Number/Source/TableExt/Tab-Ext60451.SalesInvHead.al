tableextension 60451 SalesInvHead extends "Sales Invoice Header"
{
    fields
    {
        field(60450; "Run No."; Code[20])
        {
            Caption = 'Run No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60451; "Req SSCC"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Req SSCC';
        }
        field(60452; "Req COA"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Req COA';
        }
        field(60453; "Requires Electronic Invoice"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Requires Electronic Invoice';
        }
    }
}

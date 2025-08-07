tableextension 50858 PFUserSetupExt extends "User Setup"
{
    fields
    {
        field(50850; "Can Modify Credit Limit"; Boolean)
        {
            Caption = 'Can Modify Credit Limit';
            DataClassification = ToBeClassified;
        }
        field(50851; "Sales Limit Override"; Boolean)
        {
            Caption = 'Sales Limit Override';
            DataClassification = CustomerContent;
        }
    }
}

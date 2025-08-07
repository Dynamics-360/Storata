tableextension 50857 PF_Items extends Item
{
    fields
    {
        // Add changes to table fields here
        field(50850; "Pick Group"; Option)
        {
            Caption = 'Pick Groups';
            DataClassification = SystemMetadata;
            OptionMembers = " ","1","2","3","4","5";
        }
    }
}
reportextension 50855 RemiAdvEntries extends "Remittance Advice - Entries"
{
    dataset
    {
        add("Vendor Ledger Entry")
        {
            column(GetABN; GetABN)
            {
            }
            column(VendEmail; VendEmail)
            {
            }
        }
        modify("Vendor Ledger Entry")
        {
            trigger OnAfterAfterGetRecord()
            var
                VendorRec: Record Vendor;
            begin
                Clear(VendEmail);
                if VendorRec.Get("Buy-from Vendor No.") then
                    VendEmail := VendorRec."E-Mail";
            end;
        }
    }
    rendering
    {
        layout("Remittance Advice - D360")
        {
            Type = RDLC;
            LayoutFile = './RemitAdvEntries.rdl';
        }
    }
    var
        VendEmail: Text;

    local procedure GetABN(): Text
    var
        CompanyInfo: Record "Company Information";
        ABNValue: Code[20];
        ABN: Code[20];
        FirstPart: Text;
        SecondPart: Text;
        ThirdPart: Text;
        ForthPart: Text;
    begin
        // CompanyInfo.Get();
        ABNValue := '50003529575';

        FirstPart := CopyStr(ABNValue, 1, 2);       // First 2 characters
        SecondPart := CopyStr(ABNValue, 3, 3);      // Next 3 characters
        ThirdPart := CopyStr(ABNValue, 6, 3);
        ForthPart := CopyStr(ABNValue, 9);
        // Remaining characters

        exit(FirstPart + ' ' + SecondPart + ' ' + ThirdPart + ' ' + ForthPart);

    end;


}

reportextension 50852 RemittJournlExt extends "Remittance Advice - Journal"
{
    dataset
    {
        add("Gen. Journal Line")
        {
            column(VendorEmail; VendorRec."E-Mail")

            { }
        }
        modify("Gen. Journal Line")
        {
            trigger OnAfterAfterGetRecord()
            begin
                if "Account Type" = "Account Type"::Vendor then begin
                    if VendorRec.Get("Account No.") then;
                end;

            end;
        }
        add(VendLoop)
        {
            column(GetABN; GetABN)
            {
            }
        }
    }
    rendering
    {
        // layout("RemitJnl-D360")
        // {
        //     Type = RDLC;
        //     LayoutFile = './RemittanceAdviceJournal.rdl';
        // }
        layout("Remittance Journal - D360")
        {
            Type = RDLC;
            LayoutFile = './Rep Ext/Layouts/50852_PFRemittanceJnl.rdl';
        }
    }
    var
        VendorRec: record Vendor;

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

reportextension 50859 PurchaseCreditNote extends "Purchase - Credit Memo"
{
    dataset
    {
        modify("Purch. Cr. Memo Hdr.")
        {
            trigger OnAfterAfterGetRecord()
            var
                TableCountry: Record "Country/Region";
                Vendor: Record Vendor;
            begin
                if TableCountry.Get("Ship-to Country/Region Code") then
                    Shipto_Country := TableCountry.Name
                else
                    Shipto_Country := '';

                TableCountry.Reset();
                if TableCountry.Get("Pay-to Country/Region Code") then
                    Payto_Country := TableCountry.Name
                else
                    Payto_Country := '';

                if Vendor.get("Pay-to Vendor No.") then
                    Vend_TelNo := Vendor."Phone No."
                else
                    Vend_TelNo := '';

            end;
        }
        add("Purch. Cr. Memo Hdr.")
        {
            column(ABN_Value; GetABN())
            {

            }
            column(CompanyInfoPicture; Company.Picture)
            {

            }

            column(CompanyCity; Comp_City)
            {

            }
            column(CompanyCounty; Comp_County)
            {

            }
            column(CompanyCode; Comp_Code)
            {

            }

            column(Backorder_Accepted; "Backorder Accepted")
            {

            }
            column(Ship_to_Name; "Ship-to Name")
            {

            }
            column(Ship_to_Address; "Ship-to Address")
            {

            }
            column(Ship_to_Address_2; "Ship-to Address 2")
            {

            }
            column(Ship_to_City; "Ship-to City")
            {

            }
            column(Ship_to_County; "Ship-to County")
            {

            }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {

            }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code")
            {

            }
            column(Shipto_Country1; Shipto_Country)
            {

            }
            column(Pay_to_Name; "Pay-to Name")
            {

            }
            column(Pay_to_Address; "Pay-to Address")
            {

            }
            column(Pay_to_City; "Pay-to City")
            {

            }
            column(Pay_to_Post_Code; "Pay-to Post Code")
            {

            }
            column(Pay_to_County; "Pay-to County")
            {

            }
            column(Pay_to_Country; Payto_Country)
            {

            }
            column(Vend_TelNo; Vend_TelNo)
            {

            }
        }

        add("Purch. Cr. Memo Line")
        {
            column(Item_Reference_No_; "Item Reference No.")
            {

            }

        }
    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    rendering
    {
        layout(D360PurchaseCreditNote)
        {
            Type = RDLC;
            LayoutFile = 'D360-PurchaseCreditNote.rdl';
        }
    }

    var
        Company: Record "Company Information";
        Comp_City: Text[30];
        Comp_Code: Text[20];
        Comp_county: Text[30];
        Shipto_Country: Text[50];
        Payto_Country: Text[50];
        Vend_TelNo: Text[80];

    trigger OnPreReport()
    var
        CompanyInfo: Record "Company Information";
        TableCountryRegion: Record "Country/Region";

    begin
        if CompanyInfo.get() then begin
            CompanyInfo.CalcFields(CompanyInfo.Picture);
            Company.Picture := CompanyInfo.Picture;
            Comp_City := CompanyInfo.City;
            Comp_county := CompanyInfo.County;
            Comp_Code := CompanyInfo."Post Code";
        end;



    end;

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
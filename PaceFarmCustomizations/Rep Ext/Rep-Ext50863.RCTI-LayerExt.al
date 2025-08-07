reportextension 50863 RCTILayer extends "PF RCTI"
{
    dataset
    {
        modify("Purchase Header")
        {
            trigger OnAfterAfterGetRecord()
            var
                vendor: Record Vendor;
                VendorBankAccount: Record "Vendor Bank Account";
            begin
                vendor.Reset();
                vendor.Get("Buy-from Vendor No.");
                if vendor.Find() then begin
                    VendorPhoneNo := vendor."Phone No.";
                    VendorMobilePhoneNo := vendor."Mobile Phone No.";
                    VendorEmailAddress := vendor."E-Mail";
                    VendorContactName := vendor.Contact;
                    VendorABN := vendor."Formatted ABN";
                    EggCrackPercentage := vendor."Egg Crack (%)";
                    Rate_RCTI_Barn := vendor."Premium BARN Cost EA.";
                    Rate_RCTI_BarnSec := vendor."Second BARN Cost EA.";
                    Rate_RCTI_CageFree := vendor."Premium CAGE Cost EA.";
                    Rate_RCTI_CageFreeSec := vendor."Second CAGE Cost EA.";
                    Rate_RCTI_FreeRange := vendor."Premium FREE RANGE Cost EA.";
                    Rate_RCTI_FreeRangeSec := vendor."Second FREE RANGE Cost EA.";
                    Rate_RCTI_Organic := vendor."Premium ORGANIC Cost EA.";
                    Rate_RCTI_OrganicSec := vendor."Second ORGANIC Cost EA.";
                    if (vendor."Preferred Bank Account Code" <> '') then begin
                        if VendorBankAccount.Get("Buy-from Vendor No.", vendor."Preferred Bank Account Code") then begin
                            if VendorBankAccount.Find() then begin
                                vendorbank := VendorBankAccount.Name;
                                VendorAccountNo := VendorBankAccount."Bank Account No.";
                                VendorBSB := VendorBankAccount."Bank Branch No.";
                            end;
                        end;
                    end else if (vendor."EFT Bank Account No." <> '') then begin
                        if VendorBankAccount.Get("Buy-from Vendor No.", vendor."EFT Bank Account No.") then begin
                            if VendorBankAccount.Find() then begin
                                vendorbank := VendorBankAccount.Name;
                                VendorAccountNo := VendorBankAccount."Bank Account No.";
                                VendorBSB := VendorBankAccount."Bank Branch No.";
                            end;
                        end
                    end else begin
                        vendorbank := '';
                        VendorAccountNo := '';
                        VendorBSB := '';
                    end;
                end else begin
                    VendorPhoneNo := '';
                    VendorMobilePhoneNo := '';
                    VendorEmailAddress := '';
                    VendorContactName := '';
                    VendorABN := '';
                    EggCrackPercentage := 0;
                    AGPremium := 0;
                    AGSeconds := 0;
                end;
                // RCTI_DETAILS BARN 
                RCTI_Details_.Reset();
                RCTI_Details_.SetRange("Document Type", RCTI_Details_."Document Type"::Order);
                RCTI_Details_.SetRange("Farm Method", RCTI_Details_."Farm Method"::Barn);
                RCTI_Details_.SetFilter("Document No.", "No.");
                if RCTI_Details_.FindSet() then begin
                    repeat
                        Total_RCTI_Barn := Total_RCTI_Barn + RCTI_Details_."AG Premium";
                        Total_RCTI_BarnSec := Total_RCTI_BarnSec + RCTI_Details_."AG Seconds";
                    until RCTI_Details_.Next() = 0;
                end;

                // RCTI_DETAILS FREERANGE 
                RCTI_Details_.Reset();
                RCTI_Details_.SetRange("Document Type", RCTI_Details_."Document Type"::Order);
                RCTI_Details_.SetRange("Farm Method", RCTI_Details_."Farm Method"::"Free Range");
                RCTI_Details_.SetFilter("Document No.", "No.");
                if RCTI_Details_.FindSet() then begin
                    repeat
                        Total_RCTI_FreeRange := Total_RCTI_FreeRange + RCTI_Details_."AG Premium";
                        Total_RCTI_FreeRangeSec := Total_RCTI_FreeRangeSec + RCTI_Details_."AG Seconds";
                    until RCTI_Details_.Next() = 0;
                end;
                // RCTI_DETAILS CAGEFREE
                RCTI_Details_.Reset();
                RCTI_Details_.SetRange("Document Type", RCTI_Details_."Document Type"::Order);
                RCTI_Details_.SetRange("Farm Method", RCTI_Details_."Farm Method"::Cage);
                RCTI_Details_.SetFilter("Document No.", "No.");
                if RCTI_Details_.FindSet() then begin
                    repeat
                        Total_RCTI_CageFree := Total_RCTI_CageFree + RCTI_Details_."AG Premium";
                        Total_RCTI_CageFreeSec := Total_RCTI_CageFreeSec + RCTI_Details_."AG Seconds";
                    until RCTI_Details_.Next() = 0;
                end;
                // RCTI_DETAILS ORGANIC 
                RCTI_Details_.Reset();
                RCTI_Details_.SetRange("Document Type", RCTI_Details_."Document Type"::Order);
                RCTI_Details_.SetRange("Farm Method", RCTI_Details_."Farm Method"::Organic);
                RCTI_Details_.SetFilter("Document No.", "No.");
                if RCTI_Details_.FindSet() then begin
                    repeat
                        Total_RCTI_Organic := Total_RCTI_Organic + RCTI_Details_."AG Premium";
                        Total_RCTI_OrganicSec := Total_RCTI_OrganicSec + RCTI_Details_."AG Seconds";
                    until RCTI_Details_.Next() = 0;
                end;

            end;
        }
        // Add changes to dataitems and columns here
        add("Purchase Header")
        {
            column(Pay_to_Name; "Pay-to Name")
            {

            }
            column(Pay_to_Address; "Pay-to Address")
            {

            }
            column(Pay_to_City; "Pay-to City")
            {

            }
            column(Pay_to_County; "Pay-to County")
            {

            }
            column(Pay_to_Post_Code; "Pay-to Post Code")
            {

            }
            column(Pay_to_Country_Region_Code; "Pay-to Country/Region Code")
            {

            }

            column(Invoice_Received_Date; "Invoice Received Date")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(RCTI_No_; "RCTI No.")
            {

            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {

            }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.")
            {

            }
            column(VendorPhoneNo; VendorPhoneNo)
            {

            }
            column(VendorMobilePhoneNo; VendorMobilePhoneNo)
            {

            }
            column(VendorEmailAddress; VendorEmailAddress)
            {

            }
            column(VendorContactName; VendorContactName)
            {

            }
            column(VendorABN; VendorABN)
            {

            }

            column(EggCrackPercentage; EggCrackPercentage)
            {

            }
            column(vendorbank; vendorbank)
            {

            }
            column(VendorAccountNo; VendorAccountNo)
            {

            }
            column(VendorBSB; VendorBSB)
            {

            }
            column(CompanyName; Company_Info_.Name)
            {

            }
            column(CompanyAddress; Company_Info_.Address)
            {

            }
            column(CompanyAddress2; Company_Info_."Address 2")
            {

            }
            column(CompanyCity; Company_Info_.City)
            {

            }
            column(CompanyCounty; Company_Info_.County)
            {

            }
            column(CompanyPostCode; Company_Info_."Post Code")
            {

            }
            column(CompanyPhoneNo; Company_Info_."Phone No.")
            {

            }
            column(CompanyEmail; Company_Info_."E-Mail")
            {

            }
            column(Rate_RCTI_Barn; Rate_RCTI_Barn)
            {

            }
            column(Total_RCTI_Barn; Total_RCTI_Barn)
            {

            }
            column(Rate_RCTI_BarnSec; Rate_RCTI_BarnSec)
            {

            }
            column(Total_RCTI_BarnSec; Total_RCTI_BarnSec)
            {

            }
            //
            column(Rate_RCTI_CageFree; Rate_RCTI_CageFree)
            {

            }
            column(Total_RCTI_CageFree; Total_RCTI_CageFree)
            {

            }
            column(Rate_RCTI_CageFreeSec; Rate_RCTI_CageFreeSec)
            {

            }
            column(Total_RCTI_CageFreeSec; Total_RCTI_CageFreeSec)
            {

            }
            //
            column(Rate_RCTI_FreeRange; Rate_RCTI_FreeRange)
            {

            }
            column(Total_RCTI_FreeRange; Total_RCTI_FreeRange)
            {

            }
            column(Rate_RCTI_FreeRangeSec; Rate_RCTI_FreeRangeSec)
            {

            }
            column(Total_RCTI_FreeRangeSec; Total_RCTI_FreeRangeSec)
            {

            }
            //
            column(Rate_RCTI_Organic; Rate_RCTI_Organic)
            {

            }
            column(Total_RCTI_Organic; Total_RCTI_Organic)
            {

            }
            column(Rate_RCTI_OrganicSec; Rate_RCTI_OrganicSec)
            {

            }
            column(Total_RCTI_OrganicSec; Total_RCTI_OrganicSec)
            {

            }


        }

        // Add changes to dataitems and columns here
        addfirst("Purchase Header")
        {
            dataitem(RCTIDetails; "RCTI Details")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                DataItemLinkReference = "Purchase Header";
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                column(Date; Date)
                {

                }
                column(Line_No_RCTI; "Line No.")
                {

                }
                column(Document_No_RCTI; "Document No.")
                {

                }
                column(Docket_No; "Docket No")
                {

                }
                column(Farm_Method; "Farm Method")
                {

                }
                column(BG_Premium_Eggs_EA; "BG Premium Eggs EA")
                {

                }
                column(BG_Seconds_EA; "BG Seconds EA")
                {

                }
                column(Gradeout_Cracks; "Gradeout Cracks")
                {

                }
                column(AG_Premium; "AG Premium")
                {

                }
                column(AG_Seconds; "AG Seconds")
                {

                }
                column(Total_Premium; "Total Premium")
                {

                }
                column(Total_Second; "Total Second")
                {

                }
                column(Grand_Total; Total)
                {

                }

            }
        }
    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    rendering
    {
        layout("RCTI Layer - D360")
        {
            Type = RDLC;
            LayoutFile = './Rep Ext/Layouts/50863_PFRCTILayer.rdl';
        }
    }
    var
        VendorPhoneNo: Text[30];
        VendorMobilePhoneNo: Text[30];
        VendorEmailAddress: Text[80];
        VendorContactName: Text[100];
        VendorABN: Text[15];
        EggCrackPercentage: Decimal;
        vendorbank: Text[100];
        VendorAccountNo: Text[30];
        VendorBSB: Text[30];
        AGPremium: Decimal;
        AGSeconds: Decimal;
        Company_Info_: Record "Company Information";
        RCTI_Details_: Record "RCTI Details";
        Total_RCTI_Barn: Decimal;
        Rate_RCTI_Barn: Decimal;
        Total_RCTI_CageFree: Decimal;
        Rate_RCTI_CageFree: Decimal;
        Total_RCTI_FreeRange: Decimal;
        Rate_RCTI_FreeRange: Decimal;
        Total_RCTI_Organic: Decimal;
        Rate_RCTI_Organic: Decimal;
        Total_RCTI_BarnSec: Decimal;
        Rate_RCTI_BarnSec: Decimal;
        Total_RCTI_CageFreeSec: Decimal;
        Rate_RCTI_CageFreeSec: Decimal;
        Total_RCTI_FreeRangeSec: Decimal;
        Rate_RCTI_FreeRangeSec: Decimal;
        Total_RCTI_OrganicSec: Decimal;
        Rate_RCTI_OrganicSec: Decimal;

    trigger OnPreReport()
    var
        Company: Record "Company Information";
    begin
        if Company.Get() then
            Company_Info_.Copy(Company);

    end;
}
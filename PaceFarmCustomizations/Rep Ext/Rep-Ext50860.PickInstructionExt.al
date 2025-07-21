reportextension 50860 PickInstruction extends "Pick Instruction"
{
    dataset
    {
        // Add changes to dataitems and columns here
        modify("Sales Line")
        {
            trigger OnAfterAfterGetRecord()
            var
                Item: Record Item;
                LocationTable: Record Location;
            begin
                Clear(ItemPickCode);
                Item.Reset();
                If Item.get("No.") then
                    ItemPickCode := Item."Pick Code";
                If LocationTable.get("Location Code") then
                    Location := LocationTable.Name;
            end;
        }
        modify("Sales Header")
        {
            trigger OnAfterAfterGetRecord()
            var
                TableCountryregion: Record "Country/Region";
            begin
                if TableCountryregion.Get("Ship-to Country/Region Code") then
                    ShipCountry := TableCountryregion.Name
                else
                    ShipCountry := '';
            end;
        }
        add("Sales Header")
        {
            column(Company_Pic; Company.Picture)
            {

            }
            column(GetWorkDescription; GetWorkDescription)
            {

            }
            column(PrintedTime; CurrentDateTime())
            {

            }
            column(Run_No_; "Run No.")
            {

            }
            column(Shipment_Method_Code; "Shipment Method Code")
            {

            }
            column(Shipment_Date; "Shipment Date")
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
            column(Ship_to_Code; "Ship-to Post Code")
            {

            }
            column(Ship_to_County; "Ship-to County")
            {

            }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code")
            {

            }
            column(Ship_to_Country; ShipCountry)
            {

            }
            column(Location; Location)
            {

            }
            column(Pick_Code; ItemPickCode)
            {

            }
        }
        add("Sales Line")
        {

            column(Description_2; "Description 2")
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
        layout("Pick Instruction - D360")
        {
            Type = RDLC;
            LayoutFile = './Rep Ext/Layouts/50860_PFPickInstruction.rdl';
        }
    }
    var
        ItemPickCode: Code[20];
        Company: Record "Company Information";
        ShipCountry: Text[30];
        Location: Text[100];

    trigger OnPreReport()
    var
        CompanyInfo: Record "Company Information";
    begin
        if CompanyInfo.Get() then begin
            CompanyInfo.CalcFields(Picture);
            Company.Picture := CompanyInfo.Picture;
        end;

    end;
}
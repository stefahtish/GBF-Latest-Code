report 50419 InspectionOrder2
{
    DefaultLayout = RDLC;
    RDLCLayout = './InspectionOrder2.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(EnforcementHeader; "Enforcement Header")
        {
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(Branch; Branch)
            {
            }
            column(Date; Date)
            {
            }
            column(Time; Time)
            {
            }
            column(Nature_of_milk; "Nature of milk")
            {
            }
            column(Volume; Volume)
            {
            }
            column(ClientName; "Client Name")
            {
            }
            column(License_Category; "License Category")
            {
            }
            column(LicenseNumber; "License Number")
            {
            }
            column(Location; Location)
            {
            }
            column(Market; Market)
            {
            }
            column(Confiscation_Officer_Name; "Confiscation Officer Name")
            {
            }
            column(Confiscating_Officer_Signature; "Confiscating Officer Signature")
            {
            }
            column(Officer_Designation; "Officer Designation")
            {
            }
            column(Confiscation_Owner_Signature; "Confiscation Owner Signature")
            {
            }
            column(Confiscation_Owner; "Confiscation Owner")
            {
            }
            column(Client_Designation; "Client Designation")
            {
            }
            dataitem("Enforcement NonCompliance"; "Enforcement NonCompliance")
            {
                DataItemLink = "No." = field("No.");

                column(Name; Name)
                {
                }
            }
            dataitem("Enforcement Nature of Produce"; "Enforcement Nature of Produce2")
            {
                DataItemLink = "No." = field("No.");

                column(Nature_of_Produce; "Nature of Produce")
                {
                }
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                EnforcementHeader.CalcFields("Confiscating Officer Signature");
                EnforcementHeader.CalcFields("Confiscation Owner Signature");
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}

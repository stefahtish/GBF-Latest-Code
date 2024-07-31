report 50420 ConfiscationNote2
{
    DefaultLayout = RDLC;
    RDLCLayout = './ConfiscationNote2.rdl';
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
            column(No; "No.")
            {
            }
            column(ClientName; "Client Name")
            {
            }
            column(Confiscation_Officer_Name; "Confiscation Officer Name")
            {
            }
            column(ConfiscatingOfficerSignature; "Confiscating Officer Signature")
            {
            }
            column(ConfiscationDate; "Confiscation Date")
            {
            }
            column(ConfiscationName; "Confiscation Name")
            {
            }
            column(Confiscation_Owner; "Confiscation Owner")
            {
            }
            column(ConfiscationOwnerSignature; "Confiscation Owner Signature")
            {
            }
            column(ConfiscationTime; "Confiscation Time")
            {
            }
            column(ConfiscationVenue; "Confiscation Venue")
            {
            }
            column(CountyName; "County Name")
            {
            }
            column(Address; Address)
            {
            }
            column(Vehicle_Registrtion_Number; "Vehicle Registrtion Number")
            {
            }
            column(Books_or_Records_seized; "Books or Records seized")
            {
            }
            column(Any_other_item_seized; "Any other item seized")
            {
            }
            column(Containers_seized; "Containers seized")
            {
            }
            column(Telephone_No_; "Telephone No.")
            {
            }
            column(Officer_s_Telephone_No_; "Officer's Telephone No.")
            {
            }
            column(Branch; Branch)
            {
            }
            column(Disposal; Disposal)
            {
            }
            column(Disposal_Method; "Disposal Method")
            {
            }
            column(Witnesses; Witnesses)
            {
            }
            dataitem("Items confiscated Line2"; "Items confiscated Line2")
            {
                DataItemLink = "No." = field("No.");

                column(Item; Item)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Reason_for_seizure; "Reason for seizure")
                {
                }
            }
            dataitem("Reasons for Confiscation Line2"; "Reasons for Confiscation Line2")
            {
                DataItemLink = "No." = field("No.");

                column(Code; Code)
                {
                }
                column(Description; Description)
                {
                }
                column(Remarks; Remarks)
                {
                }
            }
            dataitem("Enforcement Lines"; "Enforcement Lines")
            {
                DataItemLink = "No." = field("No.");

                column(Name; Name)
                {
                }
                column(Designation; Designation)
                {
                }
            }
            // trigger OnAfterGetRecord()
            // var
            //     Lines: Record "Enforcement Lines";
            //     i: Integer;
            // begin
            //     CalcFields("Confiscating Officer Signature", "Confiscation Owner Signature");
            //     Lines.SetRange("No.", "No.");
            //     if Lines.FindSet(false, false) then begin
            //         i := 1;
            //         repeat
            //             if i = 1 then
            //                 Witnesses := Lines.Name
            //             else
            //                 Witnesses := Witnesses + ', ' + Lines.Name;
            //             i := i + 1;
            //         until Lines.Next() = 0;
            //     end;
            // end;
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
        Witnesses: Text;
}

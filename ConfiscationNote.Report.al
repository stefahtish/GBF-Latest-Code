report 50404 ConfiscationNote
{
    RDLCLayout = './ConfiscationNote.rdl';
    WordLayout = './ConfiscationNote.docx';
    DefaultLayout = Word;
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
            column(ConfiscationDate; format(EnforcementHeader."Confiscation Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(ConfiscationName; "Confiscation Name")
            {
            }
            column(Confiscation_Owner; SentenceFormat("Confiscation Owner")) //UPPERCASE(COPYSTR("Confiscation Owner", 1, 1)) + LOWERCASE(DELSTR("Confiscation Owner", 1, 1)))
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
            column(Vehicle_Registrtion_Number; "Vehicle Registrtion Number")
            {
            }
            column(Books_or_Records_seized; SentenceFormat("Books or Records seized")) //UPPERCASE(COPYSTR("Books or Records seized", 1, 1)) + LOWERCASE(DELSTR("Books or Records seized", 1, 1)))
            {
            }
            column(Any_other_item_seized; SentenceFormat("Any other item seized")) //UPPERCASE(COPYSTR("Any other item seized", 1, 1)) + LOWERCASE(DELSTR("Any other item seized", 1, 1)))
            {
            }
            column(Containers_seized; SentenceFormat("Containers seized"))
            {
            }
            column(Telephone_No_; "Telephone No.")
            {
            }
            column(Officer_s_Telephone_No_; "Officer's Telephone No.")
            {
            }
            column(Address; Address)
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
            column(IDNumber_EnforcementHeader; "ID Number")
            {
            }
            column(PersonnelEncountered_EnforcementHeader; "Personnel Encountered")
            {
            }
            dataitem("Items confiscated Line2"; "Items confiscated Line2")
            {
                DataItemLink = "No." = field("No.");

                column(Item; SentenceFormat(Item))
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Reason_for_seizure; SentenceFormat("Reason for seizure"))
                {
                }
            }
            dataitem("Reasons for Confiscation Line2"; "Reasons for Confiscation Line2")
            {
                DataItemLink = "No." = field("No.");

                column(Code; SentenceFormat(Code))
                {
                }
                column(Description; SentenceFormat(Description))
                {
                }
                column(Remarks; SentenceFormat(Remarks))
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
            trigger OnAfterGetRecord()
            var
                Lines: Record "Enforcement Lines";
                i: Integer;
            begin
                CalcFields("Confiscating Officer Signature", "Confiscation Owner Signature");
                Lines.SetRange("No.", "No.");
                if Lines.FindSet(false, false) then begin
                    i := 1;
                    repeat
                        if i = 1 then begin
                            Witness := SentenceFormat(Lines.Name);
                            Witnesses := Witness;
                        end
                        else begin
                            Witness := SentenceFormat(Lines.Name);
                            Witnesses := Witnesses + ', ' + Witness;
                        end;
                        i := i + 1;
                    until Lines.Next() = 0;
                end;
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
        Witnesses: Text;
        Witness: Text[100];

    procedure SentenceFormat(Name: Text[1000]): Text[1000]
    var
        I: Integer;
    begin
        For I := 1 to Strlen(name) do begin
            if I = 1 then
                EVALUATE(Name[I], UPPERCASE(FORMAT(Name[I])))
            else IF Name[I - 1] = 32 THEN
                EVALUATE(Name[I], UPPERCASE(FORMAT(Name[I])))
            ELSE
                EVALUATE(Name[I], LOWERCASE(FORMAT(Name[I])));
        end;
        EXIT(Name);
    end;
}

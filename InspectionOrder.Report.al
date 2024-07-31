report 50403 InspectionOrder
{
    RDLCLayout = './InspectionOrder.rdl';
    WordLayout = './InspectionOrder.docx';
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
            column(No_; "No.")
            {
            }
            column(Branch; UPPERCASE(COPYSTR(Branch, 1, 1)) + LOWERCASE(DELSTR(Branch, 1, 1)))
            {
            }
            column(Date; Format(EnforcementHeader."Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(Time; FORMAT(EnforcementHeader.Time, 0, '<Hours12>:<Minutes,2> <AM/PM>'))
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
            column(License_Category; Sentenceformat(Category))
            {
            }
            column(LicenseNumber; "License Number")
            {
            }
            column(Location; Sentenceformat(Location))
            {
            }
            column(Market; Market)
            {
            }
            column(Confiscation_Officer_Name; Sentenceformat("Confiscation Officer Name"))
            {
            }
            column(Confiscating_Officer_Signature; "Confiscating Officer Signature")
            {
            }
            column(Officer_Designation; Sentenceformat("Officer Designation"))
            {
            }
            column(Confiscation_Owner_Signature; "Confiscation Owner Signature")
            {
            }
            column(Confiscation_Owner; Sentenceformat("Confiscation Owner"))
            {
            }
            column(Client_Designation; Sentenceformat("Client Designation"))
            {
            }
            column(NameOfPremise; SentenceFormat("Reasons for confiscation"))
            {
            }
            column(PersonnelEncountered_EnforcementHeader; "Personnel Encountered")
            {
            }
            column(Year_EnforcementHeader; Year)
            {
            }
            dataitem("Enforcement NonCompliance"; "Enforcement NonCompliance")
            {
                DataItemLink = "No." = field("No.");

                column(Name; Sentenceformat(Name))
                {
                }
                column(Status_EnforcementNonCompliance; Status)
                {
                }
            }
            dataitem("Enforcement Nature of Produce"; "Enforcement Nature of Produce2")
            {
                DataItemLink = "No." = field("No.");

                column(Nature_of_Produce; Sentenceformat("Nature of Produce"))
                {
                }
                column(Specify_EnforcementNatureofProduce; SpecifyLocal)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    SpecifyLocal := '';
                    if Specify <> '' then begin
                        SpecifyLocal := '- ' + Specify;
                    end;
                end;
            }
            // dataitem("Enforcement_Nature_of_Produce"; "Enforcement Nature of Produce2")
            // {
            //     DataItemLink = "No." = field("No.");
            //     DataItemTableView = where(Others = CONST(true));
            //     column(SpecifyEnforcementNatureofProduce; Specify)
            //     {
            //     }
            // }
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
    var
        Year: Integer;
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        SpecifyLocal: text;

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

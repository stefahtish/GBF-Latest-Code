report 50235 "KNBS Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './KNBSReport.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            column(Comp_Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Tel_No; CompanyInfo."Phone No.")
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Post_Code; CompanyInfo."Post Code")
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            column(Contract_Female; ContractFemale)
            {
            }
            column(Contract_Male; ContractMale)
            {
            }
            column(Permanent_Female; PermanentMale)
            {
            }
            column(Permanent_Male; PermanentFemale)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Emp2.Reset;
                Emp2.SetRange("Employment Type", Employee."Employment Type"::Contract);
                if Emp2.Find('-') then begin
                    case Emp2.Gender of
                        Emp2.Gender::Female:
                            begin
                                ContractFemale := Emp2.Count;
                            end;
                        Emp2.Gender::Male:
                            begin
                                ContractMale := Emp2.Count;
                            end;
                    end;
                end;
                Emp2.Reset;
                Emp2.SetRange("Employment Type", Employee."Employment Type"::Permanent);
                if Emp2.Find('-') then begin
                    case Emp2.Gender of
                        Emp2.Gender::Female:
                            begin
                                PermanentFemale := Emp2.Count;
                            end;
                        Emp2.Gender::Male:
                            begin
                                PermanentMale := Emp2.Count;
                            end;
                    end;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        ContractFemale: Integer;
        ContractMale: Integer;
        Emp2: Record Employee;
        CompanyInfo: Record "Company Information";
        PermanentMale: Integer;
        PermanentFemale: Integer;
        Empl: Record Employee;
}

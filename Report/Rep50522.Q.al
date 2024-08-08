report 50522 "Qualification Report"
{
    Caption = 'Qualification Report';
    DefaultLayout = RDLC;
    RDLCLayout = './Report/ApplicantReportSummary.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(Applicantjobapplied; "Applicant job applied")
        {
            DataItemTableView = where(Qualified = filter(true));

            RequestFilterFields = "Application No.", "Need Code", "Application Date";

            column(Comp_Name; CompInfo.Name)
            {
            }
            column(Comp_Picture; CompInfo.Picture)
            {
            }
            column(EndDate; EDate)
            {
            }
            column(StartDate; SDate)
            {
            }
            column(Need_code; "Need Code")
            {
            }
            column(JobName; Job)
            {
            }
            column(Applicant_No; "Application No.")
            {
            }
            column("Applicant_Name"; "ApplicantName")
            {
            }
            column(ApplicationDate; "Application Date")
            {
            }
            column(Age; Age)
            {
            }
            column(Gender; Gender)
            {
            }
            column(IDNumber; IDNo)
            {
            }
            dataitem(Applicants2; Applicants2)
            {
                DataItemLink = "No." = field("Application No.");
                column(CellularPhoneNumber_Applicants2; "Cellular Phone Number")
                {
                }
                column(ApplicationDate_Applicants2; "Application Date")
                {
                }
                column(DateOfBirth_Applicants2; "Date Of Birth")
                {
                }
                column(Gender_Applicants2; Gender)
                {
                }
                column(IDNumber_Applicants2; "ID Number")
                {
                }
                column(JobAppliedFor_Applicants2; "Job Applied For")
                {
                }
                column(JobDescription_Applicants2; "Job Description")
                {
                }
                column(No_Applicants2; "No.")
                {
                }
            }
            dataitem("Applicant Job Education2"; "Applicant Job Education2")
            {
                DataItemLink = "Applicant No." = field("Application No.");

                column(EducationLevel_ApplicantJobEducation2; "Education Level")
                {
                }
                column(FieldofStudy_ApplicantJobEducation2; "Field of Study")
                {
                }
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                Applicants.Reset();
                Applicants.SetRange("No.", "Application No.");
                If Applicants.FindFirst() then;
                ApplicantName := Applicants."First Name" + ' ' + Applicants."Middle Name" + ' ' + Applicants."Last Name";
                IDNo := Applicants."ID Number";
                Gender := Applicants.Gender;
                Age := Applicants.Age;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                // IF (SDate <> 0D) and (EDate <> 0D) then
                IF Applicantjobapplied.GetFilter("Application Date") = '' then begin
                    SetRange("Application Date", 0D, Today);
                end
                else
                    SetRange("Application Date", SDate, EDate);
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
        myInt: Integer;
    begin
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
        If Applicantjobapplied.GetFilter("Application Date") = '' then begin
            SDate := 0D;
            EDate := Today;
        end
        else begin
            SDate := Applicantjobapplied.GetRangeMin("Application Date");
            EDate := Applicantjobapplied.GetRangeMin("Application Date");
        end;
    end;

    var
        Applicants: Record Applicants2;
        ApplicantName: text;
        CompInfo: Record "Company Information";
        SDate: Date;
        EDate: Date;
        IDNo: Text;
        Gender: enum "Employee Gender";
        Age: Text;
}

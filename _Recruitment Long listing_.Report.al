report 50303 "Recruitment Long listing"
{
    ApplicationArea = All;
    Caption = 'Recruitment Long listing';
    UsageCategory = Administration;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Report_Recruitment_Long_listing.rdl';

    dataset
    {
        dataitem("Applicant job applied"; "Applicant job applied")
        {
            // RequestFilterFields = "Date Filter";
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
            column(PreparedBy; UserSetup.GetUserFullName(UserId))
            {
            }
            column(DatePrepared; Today)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(PreparedBy_Signature; UserSetup.Signature)
            {
            }
            column(Application_No_; ApplicantDetails[1])
            {
            }
            column(Application_Date_; ApplicantDetails[2])
            {
            }
            column(Applicant_ID_Number_; ApplicantDetails[3])
            {
            }
            column(Applicant_DoB_; ApplicantDetails[4])
            {
            }
            column(Applicant_Gender_; ApplicantDetails[5])
            {
            }
            column(Applicant_Ethnicity_; ApplicantDetails[6])
            {
            }
            column(Applicant_County_; ApplicantDetails[7])
            {
            }
            column(Applicant_Postal_Address_; ApplicantDetails[8])
            {
            }
            column(Applicant_Telephone_; ApplicantDetails[9])
            {
            }
            column(Applicant_Email_; ApplicantDetails[10])
            {
            }
            column(Applicant_Name_; ApplicantDetails[11])
            {
            }
            column(Applicant_Field_of_Study; ApplicantDetails[12])
            {
            }
            trigger OnAfterGetRecord()
            begin
                Clear(ApplicantDetails);
                ApplicantRec.Reset();
                ApplicantRec.SetRange("No.", "Application No.");
                ApplicantRec.SetRange("Application Date", StartDate, EndDate);
                if ApplicantRec.Find('-') then begin
                    ApplicantDetails[1] := ApplicantRec."No.";
                    ApplicantDetails[2] := Format(ApplicantRec."Application Date");
                    ApplicantDetails[3] := ApplicantRec."ID Number";
                    ApplicantDetails[4] := Format(ApplicantRec."Date Of Birth");
                    ApplicantDetails[5] := Format(ApplicantRec.Gender);
                    ApplicantDetails[6] := Format(ApplicantRec."Ethnic Origin");
                    ApplicantDetails[7] := ApplicantRec.County;
                    ApplicantDetails[8] := ApplicantRec."Postal Address";
                    ApplicantDetails[9] := ApplicantRec."Cellular Phone Number";
                    ApplicantDetails[10] := ApplicantRec."E-Mail";
                    //ApplicantDetails[1]:=ApplicantRec."Cellular Phone Number";
                    ApplicantDetails[11] := ApplicantRec."First Name" + ' ' + ApplicantRec."Middle Name" + ' ' + ApplicantRec."Last Name";
                end;
                ApplicantJobEduRec.Reset();
                ApplicantJobEduRec.SetRange("Applicant No.", "Application No.");
                ApplicantJobEduRec.SetRange("Highest Level", true);
                if ApplicantJobEduRec.FindFirst() then begin
                    if FieldOfStudyRec.Get(ApplicantJobEduRec."Field of Study") then ApplicantDetails[12] := FieldOfStudyRec.Description;
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Job ID", JobApplied);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field("Job Applied"; JobApplied)
                {
                    Caption = 'Job Applied';
                    Lookup = true;
                    TableRelation = "Company Job"."Job ID";
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        if CompJob.Get(JobApplied) then JobDescription := CompJob."Job Description";
                    end;
                }
                field(JobDescription; JobDescription)
                {
                    Caption = 'Job Description';
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
        actions
        {
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.get();
        CompanyInfo.CalcFields(Picture);
        //StartDate := "Applicant job applied".GetRangeMin("Date Filter");
        //EndDate := "Applicant job applied".GetRangeMax("Date Filter");
    end;

    var
        CompanyInfo: Record "Company Information";
        CompJob: Record "Company Job";
        UserSetup: Record "User Setup";
        JobApplied: Code[80];
        JobDescription: Text[250];
        ApplicantRec: Record Applicants2;
        ApplicantJobEduRec: Record "Applicant Job Education2";
        ApplicantDetails: array[20] of Text;
        FieldOfStudyRec: Record "Field of Study";
        StartDate, EndDate : Date;
}

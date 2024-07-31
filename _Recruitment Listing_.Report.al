report 50493 "Recruitment Listing"
{
    Caption = 'Recruitment Listing';
    RDLCLayout = './Reports/Report 51521624  - Recruitment Listing.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Applicants"; Applicants2)
        {
            //  DataItemTableView = Where(Applied = const(true));
            RequestFilterFields = "No.";

            column(Age_Applicants; "Applicants".Age)
            {
            }
            column(Gender_Applicants; "Applicants".Gender)
            {
            }
            column(ApplicantsNo; "Applicants"."No.")
            {
            }
            column(FullName_Applicants; "Applicants"."First Name" + ' ' + "Applicants"."Middle Name" + ' ' + "Applicants"."Last Name")
            {
            }
            column(AppID; "Applicants"."ID Number")
            {
            }
            column(AppEmail; "Applicants"."E-Mail")
            {
            }
            column(AppPhoneNo; "Applicants"."Cellular Phone Number")
            {
            }
            column(ApplicationDate; "Applicants"."Application Date")
            {
            }
            column(Citizenship; "Applicants".Citizenship)
            {
            }
            column(CountryCode; "Applicants"."Country Code")
            {
            }
            // column(HomeCounty; "Applicants"."Home County")
            // {
            // }
            // column(HomeCountyName; "Applicants"."Home County Name")
            // {
            // }
            // column(ResidentialCounty; "Applicants"."Residential County")
            // {
            // }
            // column(ResidentialCountyName; "Applicants"."Residential County Name")
            // {
            // }
            column(MaritalStatus; "Applicants"."Marital Status")
            {
            }
            column(PersonalStatus; Status)
            {
            }
            column(EthnicOrigin; "Applicants"."Ethnic Origin")
            {
            }
            column(Disabled; "Applicants".Disabled)
            {
            }
            column(DisablingDetails; "Applicants"."Disabling Details")
            {
            }
            column(Countyname; County)
            {
            }
            column(DateOfBirth; "Applicants"."Date Of Birth")
            {
            }
            column(Age; "Applicants".Age)
            {
            }
            column(PostalAddress; "Applicants"."Postal Address")
            {
            }
            column(Post_Code; "Applicants"."Post Code")
            {
            }
            column(ResidentialAddress; "Applicants"."Residential Address")
            {
            }
            column(CompanyLogo; CompInfo.Picture)
            {
            }
            column(CompanyName; CompInfo.Name)
            {
            }
            column(CompanyAddress; CompInfo.Address)
            {
            }
            column(CompanyAddress2; CompInfo."Address 2")
            {
            }
            column(CompanyPostCode; CompInfo."Post Code")
            {
            }
            column(CompanyCity; CompInfo.City)
            {
            }
            column(CompanyPhone; CompInfo."Phone No.")
            {
            }
            column(CompanyFax; CompInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompInfo."Home Page")
            {
            }
            column(CompanyCountry; CompInfo."Country/Region Code")
            {
            }
            column(AppTime; ApplicationTime)
            {
            }
            dataitem("Applicant job applied"; "Applicant job applied")
            {
                DataItemLinkReference = Applicants;
                DataItemLink = "Application No." = field("No.");

                column(Job_Applicantjobapplied; "Applicant job applied".Job)
                {
                }
                column(JobID_Applicantjobapplied; "Applicant job applied"."Job ID")
                {
                }
                column(NeedCode_Applicantjobapplied; "Applicant job applied"."Need Code")
                {
                }
                column(SystemCreatedAt; "Applicant job applied".SystemCreatedAt)
                {
                }
                dataitem(ApplicantJobEducation; "Applicant Job Education2")
                {
                    DataItemLinkReference = Applicants;
                    DataItemLink = "Applicant No." = field("No.");

                    column(StartDate; ApplicantJobEducation."Start Date")
                    {
                    }
                    column(EndDate; ApplicantJobEducation."End Date")
                    {
                    }
                    column(EducationType; ApplicantJobEducation."Education Type")
                    {
                    }
                    column(EducationLevel; ApplicantJobEducation."Education Level")
                    {
                    }
                    column(FieldofStudy; ApplicantJobEducation."Field of Study")
                    {
                    }
                    column(QualificationCode; ApplicantJobEducation."Qualification Code")
                    {
                    }
                    column(QualificationName; ApplicantJobEducation."Qualification Name")
                    {
                    }
                    column(Institution_Name; ApplicantJobEducation."Institution Name")
                    {
                    }
                    column(ProficiencyLevel; ApplicantJobEducation."Proficiency Level")
                    {
                    }
                    column(Country; ApplicantJobEducation.Country)
                    {
                    }
                    column(Region; ApplicantJobEducation.Region)
                    {
                    }
                    column(Grade; ApplicantJobEducation.Grade)
                    {
                    }
                    column(Highest_Level; ApplicantJobEducation."Highest Level")
                    {
                    }
                    column(Qualification_Code_Prof; ApplicantJobEducation."Qualification Code Prof")
                    {
                    }
                    column(Qualification_Name; "ApplicantJobEducation"."Qualification Name")
                    {
                    }
                    column(Section_Level; ApplicantJobEducation."Section/Level")
                    {
                    }
                }
                dataitem("Applicant Job Experience2"; "Applicant Job Experience2")
                {
                    DataItemLinkReference = Applicants;
                    DataItemLink = "Applicant No." = field("No.");

                    column(Employer; "Applicant Job Experience2".Employer)
                    {
                    }
                    column(Hierarchy_Level; "Applicant Job Experience2"."Hierarchy Level")
                    {
                    }
                    column(Job_Title; "Applicant Job Experience2"."Job Title")
                    {
                    }
                    column(Industry; "Applicant Job Experience2".Industry)
                    {
                    }
                    column(No__of_Years; "Applicant Job Experience2"."No. of Years")
                    {
                    }
                    column(ExpStartDate; "Applicant Job Experience2"."Start Date")
                    {
                    }
                    column(ExpEndDate; "Applicant Job Experience2"."End Date")
                    {
                    }
                    column(Currentemployment; "Applicant Job Experience2"."Current employment")
                    {
                    }
                    column(FunctionalArea; "Applicant Job Experience2"."Functional Area")
                    {
                    }
                    column(ExpCountry; "Applicant Job Experience2".Country)
                    {
                    }
                    column(Location; "Applicant Job Experience2".Location)
                    {
                    }
                    column(EmployerEmailAddress; "Applicant Job Experience2"."Employer Email Address")
                    {
                    }
                    column(Employer_Postal_Address; "Employer Postal Address")
                    {
                    }
                }
                dataitem("Applicant Prof Membership2"; "Applicant Prof Membership2")
                {
                    DataItemLinkReference = Applicants;
                    DataItemLink = "Applicant No." = field("No.");

                    column(Professional_Body; "Applicant Prof Membership2"."Professional Body")
                    {
                    }
                    column(Description; "Applicant Prof Membership2".Description)
                    {
                    }
                    column(MembershipNo; "Applicant Prof Membership2".MembershipNo)
                    {
                    }
                    column(YearofAttainment; "Applicant Prof Membership2"."Year of Attainment")
                    {
                    }
                    column(Languageproficiency; "Applicant Prof Membership2"."Language proficiency")
                    {
                    }
                }
                dataitem(ApplicantsLangProficiency; "Applicants Lang. Proficiency")
                {
                    DataItemLinkReference = Applicants;
                    DataItemLink = "No." = field("No.");

                    column(LangNo; ApplicantsLangProficiency."No.")
                    {
                    }
                    column(Language; ApplicantsLangProficiency.Language)
                    {
                    }
                    column(Read; ApplicantsLangProficiency.Read)
                    {
                    }
                    column(Write; ApplicantsLangProficiency.Write)
                    {
                    }
                    column(Speak; ApplicantsLangProficiency.Speak)
                    {
                    }
                }
                dataitem(AppSkills; ApplicantSkills)
                {
                    DataItemLinkReference = Applicants;
                    DataItemLink = "Applicant No." = field("No.");

                    column(Applicant_No_; AppSkills."Applicant No.")
                    {
                    }
                    column(Skill_Code; AppSkills."Skill Code")
                    {
                    }
                    column(SkillsDescription; AppSkills.Description)
                    {
                    }
                }
                dataitem(ApplicantReferees; "Applicant Referees2")
                {
                    DataItemLinkReference = Applicants;
                    DataItemLink = "No" = field("No.");

                    column(No; ApplicantReferees.No)
                    {
                    }
                    column(RefNames; ApplicantReferees.Names)
                    {
                    }
                    column(RefCompany; ApplicantReferees.Company)
                    {
                    }
                    column(RefAddress; Address)
                    {
                    }
                    column(RefTelephoneNo; ApplicantReferees."Telephone No")
                    {
                    }
                    column(RefEMail; ApplicantReferees."E-Mail")
                    {
                    }
                }
                dataitem(ApplicantHobbies; "Applicant Hobbies2")
                {
                    DataItemLinkReference = Applicants;
                    DataItemLink = "No." = field("No.");

                    column(HobbyNo; ApplicantHobbies."No.")
                    {
                    }
                    column(Hobbies; ApplicantHobbies.Hobbies)
                    {
                    }
                    column(HobbyLineNo; ApplicantHobbies."Line No")
                    {
                    }
                }
            }
            trigger OnAfterGetRecord()
            begin
                ApplicationTime := DT2Time("Applicants".SystemCreatedAt);
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
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
        i := 0;
    end;

    var
        CompInfo: Record "Company Information";
        "No. of Years of Experience": Decimal;
        AppJobExperience: Record "Applicant Job Experience2";
        Applicant: Record Applicants2;
        Education: array[2] of Text;
        AcademicProfDetails: array[1000, 1000] of text;
        i: Integer;
        ApplicantEducation: Record "Applicant Job Education2";
        ApplicationTime: Time;
        JobAppTime: DateTime;
}

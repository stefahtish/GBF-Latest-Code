report 50411 "Research Workplan"
{
    DefaultLayout = Word;
    RDLCLayout = './ResearchPlan.rdl';
    WordLayout = './ResearchPlan.docx';
    ApplicationArea = All;

    dataset
    {
        dataitem(ResearchandsurveyWorkplan; "Research and survey Workplan")
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
            column(Service_provider_Name; "Service provider Name")
            {
            }
            column(Estimated_Cost; "Estimated Cost")
            {
            }
            column(Code; Code)
            {
            }
            column(Category; Category)
            {
            }
            column(Nameofresearch; "Name of research")
            {
            }
            column(EndDate; Format("End Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(Town; Town)
            {
            }
            column(StartDate; Format("Start Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(Budget; Budget)
            {
            }
            column(Conclusion; ConclusionTxt)
            {
            }
            column(Country; Country)
            {
            }
            column(Country_Name; "Country Name")
            {
            }
            column(Submitted; Submitted)
            {
            }
            dataitem(PartnersLines; "ResearchSurvey Workplan Line")
            {
                DataItemLink = Code = field(Code);
                DataItemTableView = where(Type = filter(Patners));

                column(Partners; Description)
                {
                }
            }
            dataitem(ActivitiesLines; "ResearchSurvey Workplan Line")
            {
                DataItemLink = Code = field(Code);
                DataItemTableView = where(Type = filter(Scope));

                column(Activities; Description)
                {
                }
                column(Date_Held; Format("Date Held", 0, '<Day,2>/<Month,2>/<Year4>'))
                {
                }
                column(Venue_Lines; Venue)
                {
                }
                column(County_Name; "County Name")
                {
                }
                column(Outcome; Outcome)
                {
                }
            }
            dataitem("Recommendations"; "ResearchSurvey Workplan Line")
            {
                DataItemLink = Code = field(Code);
                DataItemTableView = where(Type = filter(Recommendations));

                column(Recommendation; Description)
                {
                }
            }
            dataitem(ObjectivesLines; "ResearchSurvey Workplan Line")
            {
                DataItemLink = Code = field(Code);
                DataItemTableView = where(Type = filter(Objectives));

                column(Objectives; Description)
                {
                }
                column(Output; Outcome)
                {
                }
                column(Quantification_of_outcome; "Quantification of outcome")
                {
                }
            }
            dataitem(ResearchFunding; "ResearchSurvey Workplan Line")
            {
                DataItemLink = Code = field(Code);
                DataItemTableView = where(Type = filter(Patners));

                column(Description; Description)
                {
                }
                column(Role; Role)
                {
                }
                column(BudgetaryPlan; "Budgetary Plan")
                {
                }
            }
            dataitem(Counties; "Patnership Location2")
            {
                DataItemLink = Code = field(Code);

                column(Country_Code; "Country Code")
                {
                }
                column(County; County)
                {
                }
            }
            trigger OnAfterGetRecord()
            var
            begin
                CalcFields(Conclusion);
                Conclusion.CreateInStream(InStrm);
                ConclusionBigTxt.Read(InStrm);
                ConclusionTxt := Format(ConclusionBigTxt);
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
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        InStrm: InStream;
        OutStrm: OutStream;
        OutputBigTxt: BigText;
        OutputTxt: Text;
        RecommendationBigTxt: BigText;
        RecommendationTxt: Text;
        ConclusionBigTxt: BigText;
        ConclusionTxt: Text;
}

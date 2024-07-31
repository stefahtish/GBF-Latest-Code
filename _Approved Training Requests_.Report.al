report 50203 "Approved Training Requests"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ApprovedTrainingRequests.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Training Request"; "Training Request")
        {
            DataItemTableView = WHERE(Status = CONST(Released));
            RequestFilterFields = "Training Need", "Global Dimension 1 Code", "Global Dimension 2 Code", Destination, "Planned Start Date", "Planned End Date";

            column(RequestNo_TrainingRequest; "Training Request"."Request No.")
            {
            }
            column(RequestDate_TrainingRequest; "Training Request"."Request Date")
            {
            }
            column(EmployeeNo_TrainingRequest; "Training Request"."Employee No")
            {
            }
            column(EmployeeName_TrainingRequest; "Training Request"."Employee Name")
            {
            }
            column(NoSeries_TrainingRequest; "Training Request"."No. Series")
            {
            }
            column(Status_TrainingRequest; "Training Request".Status)
            {
            }
            column(Designation_TrainingRequest; "Training Request".Designation)
            {
            }
            column(NoOfDays_TrainingRequest; "Training Request"."No. Of Days")
            {
            }
            column(TrainingInsitution_TrainingRequest; "Training Request"."Training Insitution")
            {
            }
            column(Venue_TrainingRequest; "Training Request".Venue)
            {
            }
            column(TuitionFee_TrainingRequest; "Training Request"."Tuition Fee")
            {
            }
            column(PerDiem_TrainingRequest; "Training Request"."Per Diem")
            {
            }
            column(AirTicket_TrainingRequest; "Training Request"."Air Ticket")
            {
            }
            column(TotalCost_TrainingRequest; "Training Request"."Total Cost")
            {
            }
            column(CourseTitle_TrainingRequest; "Training Request"."Course Title")
            {
            }
            column(Description_TrainingRequest; "Training Request".Description)
            {
            }
            column(PlannedStartDate_TrainingRequest; "Training Request"."Planned Start Date")
            {
            }
            column(PlannedEndDate_TrainingRequest; "Training Request"."Planned End Date")
            {
            }
            column(CountryCode_TrainingRequest; "Training Request"."Country Code")
            {
            }
            column(TotalCostLCY_TrainingRequest; "Training Request"."Total Cost (LCY)")
            {
            }
            column(Currency_TrainingRequest; "Training Request".Currency)
            {
            }
            column(Budget_TrainingRequest; "Training Request".Budget)
            {
            }
            column(Actual_TrainingRequest; "Training Request".Actual)
            {
            }
            column(Commitment_TrainingRequest; "Training Request".Commitment)
            {
            }
            column(GLAccount_TrainingRequest; "Training Request"."GL Account")
            {
            }
            column(BudgetName_TrainingRequest; "Training Request"."Budget Name")
            {
            }
            column(AvailableFunds_TrainingRequest; "Training Request"."Available Funds")
            {
            }
            column(NeedSource_TrainingRequest; "Training Request"."Need Source")
            {
            }
            column(TrainingObjective_TrainingRequest; "Training Request"."Training Objective")
            {
            }
            column(UserID_TrainingRequest; "Training Request"."User ID")
            {
            }
            column(CommisionerNo_TrainingRequest; "Training Request"."Commisioner No")
            {
            }
            column(CommissionerName_TrainingRequest; "Training Request"."Commissioner Name")
            {
            }
            column(Commissioner_TrainingRequest; "Training Request".Commissioner)
            {
            }
            column(GlobalDimension1Code_TrainingRequest; "Training Request"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_TrainingRequest; "Training Request"."Global Dimension 2 Code")
            {
            }
            column(TrainingNeed_TrainingRequest; "Training Request"."Training Need")
            {
            }
            column(Destination_TrainingRequest; "Training Request".Destination)
            {
            }
            column(CostofTraining_TrainingRequest; "Training Request"."Cost of Training")
            {
            }
            column(CostofTrainingLCY_TrainingRequest; "Training Request"."Cost of Training (LCY)")
            {
            }
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Comp_Logo; CompanyInfo.Picture)
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(Tel_No; CompanyInfo."Phone No.")
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            column(Post_Code; CompanyInfo."Post Code")
            {
            }
            trigger OnPreDataItem()
            begin
                "Training Request".SetCurrentKey("Training Need");
                //"Training Request".
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
        CompanyInfo: Record "Company Information";
}

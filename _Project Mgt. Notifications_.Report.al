report 50480 "Project Mgt. Notifications"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './projectmgtnotifications.rdl';

    dataset
    {
        dataitem(PMWorkPlan; PMWorkPlan)
        {
            column(Phase; Phase)
            {
            }
            column(Deliverable; Deliverable)
            {
            }
            column(Collection_Date; "Collection Date")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Responsible_Person; "Responsible Person")
            {
            }
            column(Project_No_; "Project No.")
            {
            }
            column(ProjectBudget; ProjectBudget)
            {
            }
            column(ProjectName; ProjectName)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(NotifyDate; NotifyDate)
            {
            }
            column(Qualifies; Qualifies)
            {
            }
            trigger OnAfterGetRecord()
            begin
                //ProjectIdentRec
                clear(ProjectBudget);
                clear(ProjectName);
                clear(StartDate);
                clear(EndDate);
                Clear(NotifyDate);
                Clear(Qualifies);
                ProjectIdentRec.Reset();
                ProjectIdentRec.SetRange("Project No.", "Project No.");
                if ProjectIdentRec.FindFirst()then begin
                    StartDate:=ProjectIdentRec."Project Start Date";
                    EndDate:=ProjectIdentRec."Project End Date";
                    ProjectBudget:=ProjectIdentRec."Project Estimated Cost";
                    ProjectName:=ProjectIdentRec."Project Name";
                end;
                if not ProjectIdentRec."Under Implementation" then CurrReport.Skip();
            end;
            trigger OnPreDataItem()
            begin
                NotifyDate:=CalcDate('1W', Today);
                PMWorkPlan.SetFilter("Notification Sent", '%1', false);
                PMWorkPlan.SetFilter("Collection Date", '%1..%2', Today, NotifyDate);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
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
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var ProjectIdentRec: Record ProjectIdentification;
    ProjectName: Text;
    ProjectBudget: Decimal;
    StartDate: Date;
    EndDate: Date;
    NotifyDate: Date;
    Qualifies: Boolean;
}

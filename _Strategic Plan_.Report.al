report 50405 "Strategic Plan"
{
    DefaultLayout = RDLC;
    RDLCLayout = './StrategicPlan.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(KeyResultArea; "Key Result Area")
        {
            column(KRA_Code; Code)
            {
            }
            column(KRA_Description; Description)
            {
            }
            dataitem("Strategic Issue"; "Strategic Issue")
            {
                DataItemLink = "KRA Code" = field(Code);

                column(Issue_Code; Code)
                {
                }
                column(issue_Description; Description)
                {
                }
                dataitem("Strategic Objective"; "Strategic Objective")
                {
                    DataItemLink = "Issue Code" = field(Code), "KRA Code" = field("KRA Code");

                    column(Objective_Code; Code)
                    {
                    }
                    column(Objective_Description; Description)
                    {
                    }
                    dataitem(Strategy; Strategy)
                    {
                        DataItemLink = "Strategy Objective No." = field(Code), "KRA" = field("KRA Code"), "Strategic Issue No." = field("Issue Code");

                        column(S_Strategy_Code; "Strategy Code")
                        {
                        }
                        column(S_Strategy; Strategy)
                        {
                        }
                        dataitem("Strategic Activity"; "Strategic Activity")
                        {
                            DataItemLink = "Strategy Code" = field("Strategy Code"), KRA = field(KRA), "Strategic Issue No." = field("Strategic Issue No."), "Strategy Objective No." = field("Strategy Objective No.");

                            column(Activity_Code; "Activity Code")
                            {
                            }
                            column(Activity; Activity2)
                            {
                            }
                            column(Output; Output)
                            {
                            }
                            column(Perfomance_indicator; "Perfomance indicator")
                            {
                            }
                            column(Total_Cost; "Total Cost")
                            {
                            }
                            column(Responsible_person; "Responsible person")
                            {
                            }
                            dataitem("Strategic Activity TimeFrame"; "Strategic Activity TimeFrame")
                            {
                                DataItemLink = "Activity Code" = field("Activity Code"), "Strategy Code" = field("Strategy Code"), KRA = field(KRA), "Strategic Issue No." = field("Strategic Issue No."), "Strategy Objective No." = field("Strategy Objective No.");

                                column(TimeFrame; TimeFrame)
                                {
                                }
                                column(Cost; Cost)
                                {
                                }
                            }
                        }
                    }
                }
            }
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
}

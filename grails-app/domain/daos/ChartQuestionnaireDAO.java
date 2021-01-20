package daos;



import java.util.ArrayList;
import java.util.List;

public class ChartQuestionnaireDAO {

    private List<String> labels;
    private List<Integer> values;
    private List<String> colors;


    public ChartQuestionnaireDAO(List<String> labels, List<Integer> values) {
        this.labels = labels;
        this.values = values;

        colors = new ArrayList<>();
        colors.add("rgb(245, 108, 108)");
        colors.add("rgb(224, 94, 198)");
        colors.add("rgb(152, 22, 156)");
        colors.add("rgb(117, 129, 235)");
        colors.add("rgb(49, 147, 245)");
        colors.add("rgb(101, 209, 54)");
        colors.add("rgb(245, 196, 49)");
        colors.add("rgb(232, 135, 23)");
        colors.add("rgb(71, 42, 7)");

    }

    public List<String> getLabels() {
        return labels;
    }

    public void setLabels(List<String> labels) {
        this.labels = labels;
    }

    public List<Integer> getValues() {
        return values;
    }

    public void setValues(List<Integer> values) {
        this.values = values;
    }

    public List<String> getColors() {
        return colors;
    }

    public void setColors(List<String> colors) {
        this.colors = colors;
    }
}
